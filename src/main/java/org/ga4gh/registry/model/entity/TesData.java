package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Entity
@Table(name = "tes_data")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TesData {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "implementation_id", nullable = false, unique = true)
    private Implementation implementation;

    @Column(name = "tasks_count")
    private Long tasksCount;

    @Column(name = "compute_availability")
    private String computeAvailability;
}
