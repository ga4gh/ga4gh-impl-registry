package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.ga4gh.registry.model.enums.DrsHostingInfra;

import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "drs_data")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DrsData {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "implementation_id", nullable = false, unique = true)
    private Implementation implementation;

    // service_info_url is intentionally absent here —
    // it lives on the implementation table as a standard-independent field

    @Column(name = "objects_count")
    private Long objectsCount;

    @Column(name = "storage_footprint_gb", precision = 20, scale = 2)
    private BigDecimal storageFootprintGb;

    @Enumerated(EnumType.STRING)
    @Column(name = "hosting_infra")
    private DrsHostingInfra hostingInfra;

    @Column(name = "query_consent")
    private Boolean queryConsent;
}
