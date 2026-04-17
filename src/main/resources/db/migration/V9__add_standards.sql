-- V9__add_standards.sql
-- Adds TRS versions 2.0.1 and 2.0.2
-- Adds Beacon (API), RNAget (API), and Passports (Security) standards with versions

-- ── TRS new versions ──────────────────────────────────────────────────────────

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'TRS'),
    '2.0.1',
    'TRS version 2.0.1'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'TRS'),
    '2.0.2',
    'TRS version 2.0.2'
) ON CONFLICT DO NOTHING;

-- ── Beacon ────────────────────────────────────────────────────────────────────
-- GA4GH Discovery Work Stream API for genomic and biomedical data discovery.
-- Beacon v2 approved as official GA4GH standard on 2022-04-21.
-- Latest release: v2.1.2 (July 2025).

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(),
    'Beacon API',
    'Beacon',
    'A data discovery API that allows federated querying of genomic and biomedical data worldwide. Supports queries on genomic variants, phenotypic and clinical data, and metadata while preserving dataset privacy and ownership.',
    'https://www.ga4gh.org/product/beacon-api/',
    (SELECT id FROM standard_type WHERE name = 'API')
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'Beacon'),
    'v1.0',
    'Beacon v1.0 — original release supporting presence/absence queries for genomic variants'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'Beacon'),
    'v2.0.0',
    'Beacon v2.0.0 — approved GA4GH standard, adds phenotypic/clinical data queries and rich metadata responses'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'Beacon'),
    'v2.1.0',
    'Beacon v2.1.0'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'Beacon'),
    'v2.1.1',
    'Beacon v2.1.1 — released December 13, 2024. Adds VRS v1.3 compatibility and improved inline documentation'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'Beacon'),
    'v2.1.2',
    'Beacon v2.1.2 — released July 1, 2025. Schema fixes and OpenAPI improvements'
) ON CONFLICT DO NOTHING;

-- ── RNAget ────────────────────────────────────────────────────────────────────
-- GA4GH API for retrieval of RNA expression data and signal/intensity data.

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(),
    'RNAget API',
    'RNAget',
    'A GA4GH API standard for retrieval of processed RNA data including feature-level expression data from RNA-seq experiments and coordinate-based signal data from ChIP-seq, methylation, or similar epigenetic experiments.',
    'https://ga4gh-rnaseq.github.io/schema/',
    (SELECT id FROM standard_type WHERE name = 'API')
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'RNAget'),
    '1.0.0',
    'RNAget v1.0.0 — initial approved release'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'RNAget'),
    '1.1.0',
    'RNAget v1.1.0 — adds GA4GH Service Info endpoint support'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'RNAget'),
    '1.2.0',
    'RNAget v1.2.0 — latest release'
) ON CONFLICT DO NOTHING;

-- ── Passports ─────────────────────────────────────────────────────────────────
-- GA4GH Data Use & Researcher Identities (DURI) Work Stream security standard.
-- Defines machine-readable digital identities (Passports) conveying data access
-- authorisations (Visas) for researchers across federated systems.
-- Standard type is 'POLICY' — Passports is a security/identity policy standard (no 'Security' type in schema).

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(),
    'Passports',
    'Passports',
    'A GA4GH security standard defining machine-readable digital identities that convey data access authorisations (Visas) for researchers. Enables role-based and attribute-based access control across federated genomic data systems.',
    'https://ga4gh.github.io/data-security/ga4gh-passport',
    (SELECT id FROM standard_type WHERE name = 'POLICY')
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'Passports'),
    '1.0',
    'Passports v1.0 — approved GA4GH standard for digital identity and data access permissions'
) ON CONFLICT DO NOTHING;
