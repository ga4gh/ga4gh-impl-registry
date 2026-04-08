package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "standard")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Standard {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private String name;

    private String abbreviation;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String url;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "standard_type_id", nullable = false)
    private StandardType standardType;

    @OneToMany(mappedBy = "standard", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<StandardVersion> versions;

    @OneToMany(mappedBy = "standard", fetch = FetchType.LAZY)
    private List<Implementation> implementations;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
