package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "standard_version")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StandardVersion {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "standard_id", nullable = false)
    private Standard standard;

    @Column(nullable = false)
    private String version;

    @Column(name = "release_date")
    private LocalDate releaseDate;

    private String url;

    @Column(columnDefinition = "TEXT")
    private String description;
}
