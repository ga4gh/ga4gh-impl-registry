package org.ga4gh.registry.config;

import org.ga4gh.registry.model.dto.*;
import org.ga4gh.registry.model.entity.*;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class RegistryMapper {

    private static final String EMAIL_SEPARATOR = ",";

    // ── Organisation ──────────────────────────────────────────────────────────

    public OrganisationDto toOrganisationDto(Organisation org) {
        return OrganisationDto.builder()
                .id(org.getId())
                .orgId(org.getOrgId())
                .name(org.getName())
                .shortName(org.getShortName())
                .url(org.getUrl())
                .description(org.getDescription())
                .build();
    }

    public Organisation toOrganisationEntity(OrganisationRequest request) {
        return Organisation.builder()
                .orgId(request.getOrgId())
                .name(request.getName())
                .shortName(request.getShortName())
                .url(request.getUrl())
                .description(request.getDescription())
                .build();
    }

    // ── Standard ──────────────────────────────────────────────────────────────

    public StandardVersionDto toStandardVersionDto(StandardVersion sv) {
        return StandardVersionDto.builder()
                .id(sv.getId())
                .version(sv.getVersion())
                .releaseDate(sv.getReleaseDate())
                .url(sv.getUrl())
                .description(sv.getDescription())
                .build();
    }

    public StandardDto toStandardDto(Standard standard) {
        List<StandardVersionDto> versions = standard.getVersions() != null
                ? standard.getVersions().stream().map(this::toStandardVersionDto).toList()
                : List.of();
        return StandardDto.builder()
                .id(standard.getId())
                .name(standard.getName())
                .abbreviation(standard.getAbbreviation())
                .description(standard.getDescription())
                .url(standard.getUrl())
                .standardType(standard.getStandardType() != null ? standard.getStandardType().getName() : null)
                .versions(versions)
                .build();
    }

    // ── Geolocation ───────────────────────────────────────────────────────────

    public GeolocationDto toGeolocationDto(Geolocation geo) {
        if (geo == null) return null;
        return GeolocationDto.builder()
                .latitude(geo.getLatitude())
                .longitude(geo.getLongitude())
                .city(geo.getCity())
                .country(geo.getCountry())
                .build();
    }

    public Geolocation toGeolocationEntity(GeolocationDto dto) {
        if (dto == null) return null;
        return Geolocation.builder()
                .latitude(dto.getLatitude())
                .longitude(dto.getLongitude())
                .city(dto.getCity())
                .country(dto.getCountry())
                .build();
    }

    // ── Email list <-> comma-separated string ─────────────────────────────────

    public String emailsToString(List<String> emails) {
        if (emails == null || emails.isEmpty()) return null;
        return emails.stream()
                .filter(StringUtils::hasText)
                .collect(Collectors.joining(EMAIL_SEPARATOR));
    }

    public List<String> stringToEmails(String emails) {
        if (!StringUtils.hasText(emails)) return Collections.emptyList();
        return Arrays.stream(emails.split(EMAIL_SEPARATOR))
                .map(String::trim)
                .filter(StringUtils::hasText)
                .toList();
    }

    // ── Standard-specific data DTOs ───────────────────────────────────────────

    public DrsDataDto toDrsDataDto(DrsData d) {
        if (d == null) return null;
        return DrsDataDto.builder()
                .objectsCount(d.getObjectsCount())
                .storageFootprintGb(d.getStorageFootprintGb())
                .hostingInfra(d.getHostingInfra())
                .queryConsent(d.getQueryConsent())
                .build();
    }

    public WesDataDto toWesDataDto(WesData d) {
        if (d == null) return null;
        return WesDataDto.builder()
                .workflowsCount(d.getWorkflowsCount())
                .workflowEngines(d.getWorkflowEngines())
                .build();
    }

    public TesDataDto toTesDataDto(TesData d) {
        if (d == null) return null;
        return TesDataDto.builder()
                .tasksCount(d.getTasksCount())
                .computeAvailability(d.getComputeAvailability())
                .build();
    }

    public TrsDataDto toTrsDataDto(TrsData d) {
        if (d == null) return null;
        return TrsDataDto.builder()
                .workflowsCount(d.getWorkflowsCount())
                .toolsCount(d.getToolsCount())
                .notebooksCount(d.getNotebooksCount())
                .build();
    }

    public ImplDataDto toImplDataDto(Implementation impl) {
        DrsDataDto drs = toDrsDataDto(impl.getDrsData());
        WesDataDto wes = toWesDataDto(impl.getWesData());
        TesDataDto tes = toTesDataDto(impl.getTesData());
        TrsDataDto trs = toTrsDataDto(impl.getTrsData());

        // Return null if no standard-specific data exists for this implementation
        if (drs == null && wes == null && tes == null && trs == null) return null;

        return ImplDataDto.builder()
                .drs(drs)
                .wes(wes)
                .tes(tes)
                .trs(trs)
                .build();
    }

    // ── Implementation ────────────────────────────────────────────────────────

    public ImplementationResponse toImplementationResponse(Implementation impl) {
        return ImplementationResponse.builder()
                .id(impl.getId())
                .implementationId(impl.getImplementationId())
                .name(impl.getName())
                .description(impl.getDescription())
                .url(impl.getUrl())
                .implementationType(impl.getImplementationType())
                .contactEmails(stringToEmails(impl.getContactEmail()))
                .documentationUrl(impl.getDocumentationUrl())
                .serviceInfoUrl(impl.getServiceInfoUrl())
                .environment(impl.getEnvironment())
                .curiePrefix(impl.getCuriePrefix())
                .organisation(toOrganisationDto(impl.getOrganisation()))
                .standardVersion(toStandardVersionDto(impl.getStandardVersion()))
                .geolocation(toGeolocationDto(impl.getGeolocation()))
                .implData(toImplDataDto(impl))
                .createdAt(impl.getCreatedAt())
                .updatedAt(impl.getUpdatedAt())
                .build();
    }
}
