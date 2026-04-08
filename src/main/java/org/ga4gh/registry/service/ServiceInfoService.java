package org.ga4gh.registry.service;

import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.config.ServiceInfoProperties;
import org.ga4gh.registry.model.dto.ServiceInfoDto;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ServiceInfoService {

    private final ServiceInfoProperties properties;

    public ServiceInfoDto getServiceInfo() {
        return ServiceInfoDto.builder()
                .id(properties.getId())
                .name(properties.getName())
                .description(properties.getDescription())
                .version(properties.getVersion())
                .environment(properties.getEnvironment())
                .contactUrl(properties.getContactUrl())
                .documentationUrl(properties.getDocumentationUrl())
                .type("org.ga4gh.registry")
                .organisation(ServiceInfoDto.OrganisationInfoDto.builder()
                        .name(properties.getOrganisationName())
                        .url(properties.getOrganisationUrl())
                        .build())
                .build();
    }
}
