package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.TesData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface TesDataRepository extends JpaRepository<TesData, UUID> {
    Optional<TesData> findByImplementationId(UUID implementationId);
}
