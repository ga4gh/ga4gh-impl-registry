package org.ga4gh.registry.model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TrsDataDto {

    private Long workflowsCount;
    private Long toolsCount;
    private Long notebooksCount;
}
