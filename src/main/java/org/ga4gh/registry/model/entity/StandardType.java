package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "standard_type")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StandardType {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, unique = true)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @OneToMany(mappedBy = "standardType", fetch = FetchType.LAZY)
    private List<Standard> standards;
}
