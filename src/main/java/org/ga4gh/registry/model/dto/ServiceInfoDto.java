package org.ga4gh.registry.model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ServiceInfoDto {

    private String id;
    private String name;
    private String description;
    private String version;
    private String environment;
    private OrganisationInfoDto organisation;
    private String contactUrl;
    private String documentationUrl;
    private String type;

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class OrganisationInfoDto {
        private String name;
        private String url;
    }
}
