package org.ga4gh.registry.controller;

import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.model.dto.ServiceInfoDto;
import org.ga4gh.registry.service.ServiceInfoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/service-info")
@RequiredArgsConstructor
public class ServiceInfoController {

    private final ServiceInfoService serviceInfoService;

    @GetMapping
    public ResponseEntity<ServiceInfoDto> getServiceInfo() {
        return ResponseEntity.ok(serviceInfoService.getServiceInfo());
    }
}
