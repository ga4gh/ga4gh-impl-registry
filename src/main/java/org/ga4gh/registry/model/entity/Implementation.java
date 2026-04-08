package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.ga4gh.registry.model.enums.Environment;
import org.ga4gh.registry.model.enums.ImplementationType;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "implementation")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Implementation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "implementation_id")
    private String implementationId;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private String url;

    @Enumerated(EnumType.STRING)
    @Column(name = "implementation_type", nullable = false)
    private ImplementationType implementationType;

    @Column(name = "contact_email", length = 1000)
    private String contactEmail;

    @Column(name = "contact_url")
    private String contactUrl;

    @Column(name = "documentation_url")
    private String documentationUrl;

    @Column(name = "service_info_url")
    private String serviceInfoUrl;

    @Enumerated(EnumType.STRING)
    @Column(name = "environment")
    private Environment environment;

    @Column(name = "curie_prefix")
    private String curiePrefix;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "organisation_id", nullable = false)
    private Organisation organisation;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "standard_id", nullable = false)
    private Standard standard;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "standard_version_id", nullable = false)
    private StandardVersion standardVersion;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "geolocation_id")
    private Geolocation geolocation;

    // No cascade — lifecycle managed explicitly via native SQL in ImplementationService
    // to avoid duplicate key violations on update
    @OneToOne(mappedBy = "implementation", fetch = FetchType.LAZY)
    private DrsData drsData;

    @OneToOne(mappedBy = "implementation", fetch = FetchType.LAZY)
    private WesData wesData;

    @OneToOne(mappedBy = "implementation", fetch = FetchType.LAZY)
    private TesData tesData;

    @OneToOne(mappedBy = "implementation", fetch = FetchType.LAZY)
    private TrsData trsData;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
