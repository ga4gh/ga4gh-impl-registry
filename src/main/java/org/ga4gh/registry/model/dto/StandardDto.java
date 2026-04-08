package org.ga4gh.registry.model.dto;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StandardDto {

    private UUID id;
    private String name;
    private String abbreviation;
    private String description;
    private String url;
    private String standardType;
    private List<StandardVersionDto> versions;
}
