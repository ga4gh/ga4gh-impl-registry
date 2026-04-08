package org.ga4gh.registry.model.dto;

import lombok.*;
import org.ga4gh.registry.model.enums.Environment;
import org.ga4gh.registry.model.enums.ImplementationType;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ImplementationResponse {

    private UUID id;
    private String implementationId;
    private String name;
    private String description;
    private String url;
    private ImplementationType implementationType;
    private List<String> contactEmails;
    private String documentationUrl;
    private String serviceInfoUrl;
    private Environment environment;
    private String curiePrefix;
    private OrganisationDto organisation;
    private StandardVersionDto standardVersion;
    private GeolocationDto geolocation;

    // Standard-specific fields nested under implData —
    // only one child (drs/wes/tes/trs) will be non-null
    private ImplDataDto implData;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
