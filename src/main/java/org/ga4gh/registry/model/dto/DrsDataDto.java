package org.ga4gh.registry.model.dto;

import lombok.*;
import org.ga4gh.registry.model.enums.DrsHostingInfra;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DrsDataDto {

    // serviceInfoUrl is intentionally absent here —
    // it is a standard-independent field returned at the root of ImplementationResponse

    private Long objectsCount;
    private BigDecimal storageFootprintGb;
    private DrsHostingInfra hostingInfra;
    private Boolean queryConsent;
}
