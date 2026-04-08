package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.StandardVersion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface StandardVersionRepository extends JpaRepository<StandardVersion, UUID> {
    List<StandardVersion> findByStandardId(UUID standardId);
}
