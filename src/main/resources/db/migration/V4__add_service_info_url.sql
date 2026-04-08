-- V4__add_service_info_url.sql

ALTER TABLE implementation
    ADD COLUMN IF NOT EXISTS service_info_url VARCHAR(500);