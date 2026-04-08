package org.ga4gh.registry.model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ImplDataDto {

    // Only one of these will be non-null per implementation,
    // determined by which standard the implementation belongs to.
    private DrsDataDto drs;
    private WesDataDto wes;
    private TesDataDto tes;
    private TrsDataDto trs;
}
