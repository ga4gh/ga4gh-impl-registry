package org.ga4gh.registry.model.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StandardVersionDto {

    private UUID id;
    private String version;
    private LocalDate releaseDate;
    private String url;
    private String description;
    // The GA4GH standard this version belongs to e.g. DRS, WES, TES, TRS
    private String ga4ghProduct;
}
