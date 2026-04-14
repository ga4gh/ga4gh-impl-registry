package org.ga4gh.registry.service;

import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.config.RegistryMapper;
import org.ga4gh.registry.exception.ResourceNotFoundException;
import org.ga4gh.registry.model.dto.OrganisationDto;
import org.ga4gh.registry.model.dto.OrganisationRequest;
import org.ga4gh.registry.model.entity.Organisation;
import org.ga4gh.registry.repository.OrganisationRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrganisationService {

    private final OrganisationRepository organisationRepository;
    private final RegistryMapper mapper;

    public List<OrganisationDto> getAllOrganisations() {
        return organisationRepository.findAll()
                .stream()
                .map(mapper::toOrganisationDto)
                .toList();
    }

    public OrganisationDto getOrganisationById(UUID id) {
        Organisation org = organisationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Organisation", id.toString()));
        return mapper.toOrganisationDto(org);
    }

    public OrganisationDto createOrganisation(OrganisationRequest request) {
        Organisation org = mapper.toOrganisationEntity(request);
        return mapper.toOrganisationDto(organisationRepository.save(org));
    }

    public OrganisationDto updateOrganisation(UUID id, OrganisationRequest request) {
        Organisation org = organisationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Organisation", id.toString()));
        org.setOrgId(request.getOrgId());
        org.setName(request.getName());
        org.setShortName(request.getShortName());
        org.setUrl(request.getUrl());
        org.setDescription(request.getDescription());
        return mapper.toOrganisationDto(organisationRepository.save(org));
    }
}
