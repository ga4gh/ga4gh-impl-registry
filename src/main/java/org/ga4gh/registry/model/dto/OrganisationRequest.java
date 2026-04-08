package org.ga4gh.registry.model.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrganisationRequest {

    private String orgId;

    @NotBlank(message = "Organisation name is required")
    private String name;

    private String shortName;
    private String url;
    private String description;
}
