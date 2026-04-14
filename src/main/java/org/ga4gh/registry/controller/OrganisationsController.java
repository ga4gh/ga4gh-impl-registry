package org.ga4gh.registry.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.model.dto.OrganisationDto;
import org.ga4gh.registry.model.dto.OrganisationRequest;
import org.ga4gh.registry.service.OrganisationService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/organisations")
@RequiredArgsConstructor
public class OrganisationsController {

    private final OrganisationService organisationService;

    @GetMapping
    public ResponseEntity<List<OrganisationDto>> getAllOrganisations() {
        return ResponseEntity.ok(organisationService.getAllOrganisations());
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrganisationDto> getOrganisationById(@PathVariable UUID id) {
        return ResponseEntity.ok(organisationService.getOrganisationById(id));
    }

    @PostMapping
    public ResponseEntity<OrganisationDto> createOrganisation(
            @Valid @RequestBody OrganisationRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(organisationService.createOrganisation(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrganisationDto> updateOrganisation(
            @PathVariable UUID id,
            @Valid @RequestBody OrganisationRequest request) {
        return ResponseEntity.ok(organisationService.updateOrganisation(id, request));
    }
}
