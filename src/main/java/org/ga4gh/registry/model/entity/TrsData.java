package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Entity
@Table(name = "trs_data")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TrsData {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "implementation_id", nullable = false, unique = true)
    private Implementation implementation;

    @Column(name = "workflows_count")
    private Long workflowsCount;

    @Column(name = "tools_count")
    private Long toolsCount;

    @Column(name = "notebooks_count")
    private Long notebooksCount;
}
