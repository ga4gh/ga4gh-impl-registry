-- V2__extend_schema.sql

-- Add implementation_id (user-provided, domain-reversed identifier) and other new fields to implementation
ALTER TABLE implementation
    ADD COLUMN implementation_id VARCHAR(255),
    ADD COLUMN contact_email VARCHAR(1000),
    ADD COLUMN environment VARCHAR(50) CHECK (environment IN ('PRODUCTION', 'DEVELOPMENT', 'TEST', 'OTHER')),
    ADD COLUMN curie_prefix VARCHAR(255);

-- Drop old contact_url from implementation (replaced by contact_email)
-- Kept as nullable for backwards compatibility; remove in future migration if desired
ALTER TABLE implementation ALTER COLUMN contact_url DROP NOT NULL;

-- DRS-specific fields on implementation (null for non-DRS implementations)
ALTER TABLE implementation
    ADD COLUMN drs_service_info_url VARCHAR(500),
    ADD COLUMN drs_objects_count BIGINT,
    ADD COLUMN drs_storage_footprint_gb NUMERIC(20, 2),
    ADD COLUMN drs_hosting_infra VARCHAR(50) CHECK (drs_hosting_infra IN ('COMMERCIAL_CLOUD', 'PRIVATE_CLOUD', 'ON_PREMISES')),
    ADD COLUMN drs_query_consent BOOLEAN;

-- Add org_id (user-provided, URL-reversed identifier) to organisation
ALTER TABLE organisation
    ADD COLUMN org_id VARCHAR(255);
