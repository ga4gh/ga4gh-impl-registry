-- V1__initial_schema.sql

CREATE TABLE organisation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    short_name VARCHAR(100),
    url VARCHAR(500),
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE standard_type (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE standard (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    description TEXT,
    url VARCHAR(500),
    standard_type_id UUID NOT NULL REFERENCES standard_type(id),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE standard_version (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    standard_id UUID NOT NULL REFERENCES standard(id),
    version VARCHAR(50) NOT NULL,
    release_date DATE,
    url VARCHAR(500),
    description TEXT,
    UNIQUE (standard_id, version)
);

CREATE TABLE geolocation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    latitude DECIMAL(10, 7) NOT NULL,
    longitude DECIMAL(10, 7) NOT NULL,
    city VARCHAR(255),
    country VARCHAR(255) NOT NULL
);

CREATE TABLE implementation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    url VARCHAR(500) NOT NULL,
    implementation_type VARCHAR(50) NOT NULL CHECK (implementation_type IN ('SERVICE', 'DEPLOYMENT')),
    organisation_id UUID NOT NULL REFERENCES organisation(id),
    standard_id UUID NOT NULL REFERENCES standard(id),
    standard_version_id UUID NOT NULL REFERENCES standard_version(id),
    geolocation_id UUID REFERENCES geolocation(id),
    contact_url VARCHAR(500),
    documentation_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Seed standard types
INSERT INTO standard_type (name, description) VALUES
    ('API', 'Application Programming Interface standard'),
    ('FILE_FORMAT', 'File format standard'),
    ('SCHEMA', 'Data schema standard'),
    ('POLICY', 'Policy or compliance standard');

-- Seed GA4GH Cloud API standards
INSERT INTO standard (name, abbreviation, description, url, standard_type_id)
VALUES
    ('Data Repository Service', 'DRS', 'GA4GH standard for accessing data objects', 'https://ga4gh.github.io/data-repository-service-schemas', (SELECT id FROM standard_type WHERE name = 'API')),
    ('Workflow Execution Service', 'WES', 'GA4GH standard for executing workflows', 'https://ga4gh.github.io/workflow-execution-service-schemas', (SELECT id FROM standard_type WHERE name = 'API')),
    ('Task Execution Service', 'TES', 'GA4GH standard for executing computational tasks', 'https://ga4gh.github.io/task-execution-schemas', (SELECT id FROM standard_type WHERE name = 'API')),
    ('Tool Registry Service', 'TRS', 'GA4GH standard for registering and discovering tools', 'https://ga4gh.github.io/tool-registry-service-schemas', (SELECT id FROM standard_type WHERE name = 'API'));

-- Seed standard versions
INSERT INTO standard_version (standard_id, version, description) VALUES
    ((SELECT id FROM standard WHERE abbreviation = 'DRS'), '1.0.0', 'DRS version 1.0.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'DRS'), '1.1.0', 'DRS version 1.1.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'DRS'), '1.2.0', 'DRS version 1.2.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'WES'), '1.0.0', 'WES version 1.0.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'WES'), '1.1.0', 'WES version 1.1.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'TES'), '1.0.0', 'TES version 1.0.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'TES'), '1.1.0', 'TES version 1.1.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'TRS'), '2.0.0', 'TRS version 2.0.0'),
    ((SELECT id FROM standard WHERE abbreviation = 'TRS'), '2.1.0', 'TRS version 2.1.0');
