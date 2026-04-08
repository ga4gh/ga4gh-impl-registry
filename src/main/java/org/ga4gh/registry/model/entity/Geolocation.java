package org.ga4gh.registry.model.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "geolocation")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Geolocation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal latitude;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal longitude;

    private String city;

    @Column(nullable = false)
    private String country;
}
