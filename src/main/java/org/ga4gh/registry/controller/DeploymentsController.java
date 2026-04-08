package org.ga4gh.registry.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.model.dto.ImplementationRequest;
import org.ga4gh.registry.model.dto.ImplementationResponse;
import org.ga4gh.registry.model.enums.ImplementationType;
import org.ga4gh.registry.service.ImplementationService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/deployments")
@RequiredArgsConstructor
public class DeploymentsController {

    private final ImplementationService implementationService;

    @GetMapping
    public ResponseEntity<List<ImplementationResponse>> getAllDeployments() {
        return ResponseEntity.ok(implementationService.getDeployments());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ImplementationResponse> getDeploymentById(@PathVariable UUID id) {
        return ResponseEntity.ok(implementationService.getDeploymentById(id));
    }

    @PostMapping
    public ResponseEntity<ImplementationResponse> createDeployment(
            @Valid @RequestBody ImplementationRequest request) {
        request.setImplementationType(ImplementationType.DEPLOYMENT);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(implementationService.createImplementation(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ImplementationResponse> updateDeployment(
            @PathVariable UUID id,
            @Valid @RequestBody ImplementationRequest request) {
        request.setImplementationType(ImplementationType.DEPLOYMENT);
        return ResponseEntity.ok(implementationService.updateImplementation(id, request));
    }
}
