package org.ga4gh.registry.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.config.RegistryMapper;
import org.ga4gh.registry.exception.ResourceNotFoundException;
import org.ga4gh.registry.model.dto.*;
import org.ga4gh.registry.model.entity.*;
import org.ga4gh.registry.model.enums.ImplementationType;
import org.ga4gh.registry.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ImplementationService {

    private final ImplementationRepository implementationRepository;
    private final OrganisationRepository organisationRepository;
    private final StandardRepository standardRepository;
    private final StandardVersionRepository standardVersionRepository;
    private final DrsDataRepository drsDataRepository;
    private final WesDataRepository wesDataRepository;
    private final TesDataRepository tesDataRepository;
    private final TrsDataRepository trsDataRepository;
    private final RegistryMapper mapper;

    @PersistenceContext
    private EntityManager entityManager;

    public List<ImplementationResponse> getAllImplementations() {
        return implementationRepository.findAll()
                .stream()
                .map(mapper::toImplementationResponse)
                .toList();
    }

    public ImplementationResponse getImplementationById(UUID id) {
        return mapper.toImplementationResponse(findImplOrThrow(id, "Implementation"));
    }

    public List<ImplementationResponse> getServices() {
        return implementationRepository.findByImplementationType(ImplementationType.SERVICE)
                .stream().map(mapper::toImplementationResponse).toList();
    }

    public ImplementationResponse getServiceById(UUID id) {
        Implementation impl = findImplOrThrow(id, "Service");
        if (impl.getImplementationType() != ImplementationType.SERVICE) {
            throw new ResourceNotFoundException("Service", id.toString());
        }
        return mapper.toImplementationResponse(impl);
    }

    public List<ImplementationResponse> getDeployments() {
        return implementationRepository.findByImplementationType(ImplementationType.DEPLOYMENT)
                .stream().map(mapper::toImplementationResponse).toList();
    }

    public ImplementationResponse getDeploymentById(UUID id) {
        Implementation impl = findImplOrThrow(id, "Deployment");
        if (impl.getImplementationType() != ImplementationType.DEPLOYMENT) {
            throw new ResourceNotFoundException("Deployment", id.toString());
        }
        return mapper.toImplementationResponse(impl);
    }

    @Transactional
    public ImplementationResponse createImplementation(ImplementationRequest request) {
        Organisation organisation = resolveOrganisation(request.getOrganisationId());
        Standard standard = resolveStandard(request.getStandardId());
        StandardVersion standardVersion = resolveStandardVersion(request.getStandardVersionId(), standard);
        Geolocation geolocation = mapper.toGeolocationEntity(request.getGeolocation());

        Implementation impl = Implementation.builder()
                .implementationId(request.getImplementationId())
                .name(request.getName())
                .description(request.getDescription())
                .url(request.getUrl())
                .implementationType(request.getImplementationType())
                .contactEmail(mapper.emailsToString(request.getContactEmails()))
                .documentationUrl(request.getDocumentationUrl())
                .serviceInfoUrl(request.getServiceInfoUrl())
                .environment(request.getEnvironment())
                .curiePrefix(request.getCuriePrefix())
                .organisation(organisation)
                .standard(standard)
                .standardVersion(standardVersion)
                .geolocation(geolocation)
                .build();

        Implementation saved = implementationRepository.save(impl);
        saveImplData(saved.getId(), request.getImplData(), standard.getAbbreviation());
        entityManager.flush();
        entityManager.clear();
        return mapper.toImplementationResponse(implementationRepository.findById(saved.getId()).orElseThrow());
    }

    @Transactional
    public ImplementationResponse updateImplementation(UUID id, ImplementationRequest request) {
        // Step 1 — delete all standard-specific rows via native SQL
        // before Hibernate loads anything into its session cache
        purgeImplData(id);
        entityManager.flush();

        // Step 2 — load the implementation fresh after the purge
        Implementation impl = findImplOrThrow(id, "Implementation");

        Standard standard = resolveStandard(request.getStandardId());
        StandardVersion standardVersion = resolveStandardVersion(request.getStandardVersionId(), standard);
        Organisation organisation = resolveOrganisation(request.getOrganisationId());

        // Step 3 — update all scalar fields
        impl.setImplementationId(request.getImplementationId());
        impl.setName(request.getName());
        impl.setDescription(request.getDescription());
        impl.setUrl(request.getUrl());
        impl.setImplementationType(request.getImplementationType());
        impl.setContactEmail(mapper.emailsToString(request.getContactEmails()));
        impl.setDocumentationUrl(request.getDocumentationUrl());
        impl.setServiceInfoUrl(request.getServiceInfoUrl());
        impl.setEnvironment(request.getEnvironment());
        impl.setCuriePrefix(request.getCuriePrefix());
        impl.setOrganisation(organisation);
        impl.setStandard(standard);
        impl.setStandardVersion(standardVersion);
        impl.setGeolocation(request.getGeolocation() != null
                ? mapper.toGeolocationEntity(request.getGeolocation())
                : null);

        implementationRepository.save(impl);

        // Step 4 — insert fresh standard-specific rows
        saveImplData(id, request.getImplData(), standard.getAbbreviation());

        // Step 5 — flush and clear before final reload so response reflects all changes
        entityManager.flush();
        entityManager.clear();

        return mapper.toImplementationResponse(implementationRepository.findById(id).orElseThrow());
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    /**
     * Deletes all standard-specific rows for the given implementation
     * using native SQL — bypasses Hibernate's session cache entirely,
     * preventing duplicate key violations on re-insert.
     */
    private void purgeImplData(UUID implementationId) {
        entityManager.createNativeQuery("DELETE FROM drs_data WHERE implementation_id = :id")
                .setParameter("id", implementationId)
                .executeUpdate();
        entityManager.createNativeQuery("DELETE FROM wes_data WHERE implementation_id = :id")
                .setParameter("id", implementationId)
                .executeUpdate();
        entityManager.createNativeQuery("DELETE FROM tes_data WHERE implementation_id = :id")
                .setParameter("id", implementationId)
                .executeUpdate();
        entityManager.createNativeQuery("DELETE FROM trs_data WHERE implementation_id = :id")
                .setParameter("id", implementationId)
                .executeUpdate();
    }

    private void saveImplData(UUID implId, ImplDataDto implData, String standardAbbreviation) {
        if (implData == null) return;

        // Fetch a reference for the FK — avoids loading full entity
        Implementation ref = entityManager.getReference(Implementation.class, implId);

        switch (standardAbbreviation.toUpperCase()) {
            case "DRS" -> {
                DrsDataDto dto = implData.getDrs();
                if (dto != null) {
                    drsDataRepository.save(DrsData.builder()
                            .implementation(ref)
                            .objectsCount(dto.getObjectsCount())
                            .storageFootprintGb(dto.getStorageFootprintGb())
                            .hostingInfra(dto.getHostingInfra())
                            .queryConsent(dto.getQueryConsent())
                            .build());
                }
            }
            case "WES" -> {
                WesDataDto dto = implData.getWes();
                if (dto != null) {
                    wesDataRepository.save(WesData.builder()
                            .implementation(ref)
                            .workflowsCount(dto.getWorkflowsCount())
                            .workflowEngines(dto.getWorkflowEngines())
                            .build());
                }
            }
            case "TES" -> {
                TesDataDto dto = implData.getTes();
                if (dto != null) {
                    tesDataRepository.save(TesData.builder()
                            .implementation(ref)
                            .tasksCount(dto.getTasksCount())
                            .computeAvailability(dto.getComputeAvailability())
                            .build());
                }
            }
            case "TRS" -> {
                TrsDataDto dto = implData.getTrs();
                if (dto != null) {
                    trsDataRepository.save(TrsData.builder()
                            .implementation(ref)
                            .workflowsCount(dto.getWorkflowsCount())
                            .toolsCount(dto.getToolsCount())
                            .notebooksCount(dto.getNotebooksCount())
                            .build());
                }
            }
        }
    }

    private Organisation resolveOrganisation(UUID id) {
        return organisationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Organisation", id.toString()));
    }

    private Standard resolveStandard(UUID id) {
        return standardRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Standard", id.toString()));
    }

    private StandardVersion resolveStandardVersion(UUID id, Standard standard) {
        StandardVersion sv = standardVersionRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("StandardVersion", id.toString()));
        if (!sv.getStandard().getId().equals(standard.getId())) {
            throw new IllegalArgumentException("Standard version does not belong to the specified standard");
        }
        return sv;
    }

    private Implementation findImplOrThrow(UUID id, String resourceName) {
        return implementationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(resourceName, id.toString()));
    }
}
