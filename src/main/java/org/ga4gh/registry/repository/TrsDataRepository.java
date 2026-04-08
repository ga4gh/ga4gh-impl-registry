package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.TrsData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface TrsDataRepository extends JpaRepository<TrsData, UUID> {
    Optional<TrsData> findByImplementationId(UUID implementationId);
}
