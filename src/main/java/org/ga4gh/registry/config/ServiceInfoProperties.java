package org.ga4gh.registry.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "registry.service-info")
@Getter
@Setter
public class ServiceInfoProperties {

    private String id;
    private String name;
    private String description;
    private String organisationName;
    private String organisationUrl;
    private String contactUrl;
    private String documentationUrl;
    private String version;
    private String environment;
}
