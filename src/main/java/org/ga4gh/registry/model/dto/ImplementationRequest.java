package org.ga4gh.registry.model.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.ga4gh.registry.model.enums.Environment;
import org.ga4gh.registry.model.enums.ImplementationType;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ImplementationRequest {

    private String implementationId;

    @NotBlank(message = "Name is required")
    private String name;

    private String description;

    @NotBlank(message = "URL is required")
    private String url;

    @NotNull(message = "Implementation type is required (SERVICE or DEPLOYMENT)")
    private ImplementationType implementationType;

    private List<String> contactEmails;
    private String documentationUrl;
    private String serviceInfoUrl;
    private Environment environment;
    private String curiePrefix;

    @NotNull(message = "Organisation ID is required")
    private UUID organisationId;

    @NotNull(message = "Standard ID is required")
    private UUID standardId;

    @NotNull(message = "Standard version ID is required")
    private UUID standardVersionId;

    @Valid
    private GeolocationDto geolocation;

    // Standard-specific data — only one should be populated per request,
    // matching the selected standard
    @Valid
    private ImplDataDto implData;
}
