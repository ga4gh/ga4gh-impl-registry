package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.Implementation;
import org.ga4gh.registry.model.enums.ImplementationType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ImplementationRepository extends JpaRepository<Implementation, UUID> {
    List<Implementation> findByImplementationType(ImplementationType type);
    List<Implementation> findByOrganisationId(UUID organisationId);
    List<Implementation> findByStandardId(UUID standardId);
}
