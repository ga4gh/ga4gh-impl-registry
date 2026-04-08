package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.DrsData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface DrsDataRepository extends JpaRepository<DrsData, UUID> {
    Optional<DrsData> findByImplementationId(UUID implementationId);
}
