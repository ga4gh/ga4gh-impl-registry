-- V7__add_refget_seqcol_standards.sql
-- Adds refget Sequence Collections (seqcol) v1.0.0 as a new standard
-- and refget Sequences v2.0.0 as a new version of the existing refget standard

-- ── refget Sequences v2.0.0 ──────────────────────────────────────────────────
-- The refget standard already exists in the database (inserted in V6).
-- Adding v2.0.0 as a new standard version alongside the existing v1.0.0.

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'refget'),
    '2.0.0',
    'refget Sequences v2.0.0 — adds support for non-unique sequence names, compatibility with GA4GH Service Info API, and VRS sequence identifiers'
) ON CONFLICT DO NOTHING;

-- ── refget Sequence Collections (seqcol) ─────────────────────────────────────
-- A distinct GA4GH standard from refget Sequences.
-- Provides unique identifiers for collections of sequences (e.g. reference genomes).

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(),
    'refget Sequence Collections',
    'seqcol',
    'GA4GH standard for generating unique identifiers for collections of biological sequences such as reference genomes, transcriptomes, and proteomes. Extends refget Sequences to operate over groups of sequences.',
    'https://ga4gh.github.io/refget/seqcols/',
    (SELECT id FROM standard_type WHERE name = 'API')
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'seqcol'),
    '1.0.0',
    'refget Sequence Collections v1.0.0 — initial approved GA4GH product release'
) ON CONFLICT DO NOTHING;
