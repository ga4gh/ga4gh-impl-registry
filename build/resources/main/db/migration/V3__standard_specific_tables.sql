-- V3__standard_specific_tables.sql

-- DRS-specific data
CREATE TABLE drs_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    implementation_id UUID NOT NULL UNIQUE REFERENCES implementation(id) ON DELETE CASCADE,
    service_info_url VARCHAR(500),
    objects_count BIGINT,
    storage_footprint_gb NUMERIC(20, 2),
    hosting_infra VARCHAR(50) CHECK (hosting_infra IN ('COMMERCIAL_CLOUD', 'PRIVATE_CLOUD', 'ON_PREMISES')),
    query_consent BOOLEAN
);

-- WES-specific data
CREATE TABLE wes_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    implementation_id UUID NOT NULL UNIQUE REFERENCES implementation(id) ON DELETE CASCADE,
    workflows_count BIGINT,
    workflow_engines VARCHAR(500)
);

-- TES-specific data
CREATE TABLE tes_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    implementation_id UUID NOT NULL UNIQUE REFERENCES implementation(id) ON DELETE CASCADE,
    tasks_count BIGINT,
    compute_availability VARCHAR(500)
);

-- TRS-specific data
CREATE TABLE trs_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    implementation_id UUID NOT NULL UNIQUE REFERENCES implementation(id) ON DELETE CASCADE,
    workflows_count BIGINT,
    tools_count BIGINT,
    notebooks_count BIGINT
);

-- Drop the old flat DRS columns from implementation
ALTER TABLE implementation
    DROP COLUMN IF EXISTS drs_service_info_url,
    DROP COLUMN IF EXISTS drs_objects_count,
    DROP COLUMN IF EXISTS drs_storage_footprint_gb,
    DROP COLUMN IF EXISTS drs_hosting_infra,
    DROP COLUMN IF EXISTS drs_query_consent;
