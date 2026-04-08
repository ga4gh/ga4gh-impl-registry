package org.ga4gh.registry.service;

import lombok.RequiredArgsConstructor;
import org.ga4gh.registry.config.RegistryMapper;
import org.ga4gh.registry.exception.ResourceNotFoundException;
import org.ga4gh.registry.model.dto.StandardDto;
import org.ga4gh.registry.model.entity.Standard;
import org.ga4gh.registry.repository.StandardRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class StandardService {

    private final StandardRepository standardRepository;
    private final RegistryMapper mapper;

    public List<StandardDto> getAllStandards() {
        return standardRepository.findAll()
                .stream()
                .map(mapper::toStandardDto)
                .toList();
    }

    public StandardDto getStandardById(UUID id) {
        Standard standard = standardRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Standard", id.toString()));
        return mapper.toStandardDto(standard);
    }
}
