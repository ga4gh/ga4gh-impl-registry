package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.WesData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface WesDataRepository extends JpaRepository<WesData, UUID> {
    Optional<WesData> findByImplementationId(UUID implementationId);
}
