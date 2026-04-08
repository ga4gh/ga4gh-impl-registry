package org.ga4gh.registry.model.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrganisationDto {

    private UUID id;
    private String orgId;
    private String name;
    private String shortName;
    private String url;
    private String description;
}
