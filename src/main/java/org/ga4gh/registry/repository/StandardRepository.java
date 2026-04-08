package org.ga4gh.registry.repository;

import org.ga4gh.registry.model.entity.Standard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface StandardRepository extends JpaRepository<Standard, UUID> {
}
