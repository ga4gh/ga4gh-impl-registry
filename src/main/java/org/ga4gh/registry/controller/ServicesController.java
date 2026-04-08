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
@RequestMapping("/api/services")
@RequiredArgsConstructor
public class ServicesController {

    private final ImplementationService implementationService;

    @GetMapping
    public ResponseEntity<List<ImplementationResponse>> getAllServices() {
        return ResponseEntity.ok(implementationService.getServices());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ImplementationResponse> getServiceById(@PathVariable UUID id) {
        return ResponseEntity.ok(implementationService.getServiceById(id));
    }

    @PostMapping
    public ResponseEntity<ImplementationResponse> createService(
            @Valid @RequestBody ImplementationRequest request) {
        request.setImplementationType(ImplementationType.SERVICE);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(implementationService.createImplementation(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ImplementationResponse> updateService(
            @PathVariable UUID id,
            @Valid @RequestBody ImplementationRequest request) {
        request.setImplementationType(ImplementationType.SERVICE);
        return ResponseEntity.ok(implementationService.updateImplementation(id, request));
    }
}
