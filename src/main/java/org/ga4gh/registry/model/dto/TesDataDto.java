package org.ga4gh.registry.model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TesDataDto {

    private Long tasksCount;
    private String computeAvailability;
}
