package org.ga4gh.registry.controller;

import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.model.dto.StandardDto;
import org.ga4gh.registry.service.StandardService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/standards")
@RequiredArgsConstructor
public class StandardsController {

    private final StandardService standardService;

    @GetMapping
    public ResponseEntity<List<StandardDto>> getAllStandards() {
        return ResponseEntity.ok(standardService.getAllStandards());
    }

    @GetMapping("/{id}")
    public ResponseEntity<StandardDto> getStandardById(@PathVariable UUID id) {
        return ResponseEntity.ok(standardService.getStandardById(id));
    }
}
