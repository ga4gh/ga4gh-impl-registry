-- V5__remove_drs_service_info_url.sql
-- service_info_url is a standard-independent field that lives on the
-- implementation table. Removing it from drs_data to avoid duplication.

ALTER TABLE drs_data
    DROP COLUMN IF EXISTS service_info_url;
