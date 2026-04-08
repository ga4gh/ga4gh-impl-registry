package org.ga4gh.registry.model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WesDataDto {

    private Long workflowsCount;
    private String workflowEngines;
}
