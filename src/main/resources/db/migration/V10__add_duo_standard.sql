-- V10__add_duo_standard.sql
-- Adds the GA4GH Data Use Ontology (DUO) standard.
-- Note: DUOS (Data Use Oversight System) is a Broad Institute software
-- implementation of DUO, not the standard itself. The standard is DUO.

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(),
    'Data Use Ontology',
    'DUO',
    'A GA4GH standard providing a shared vocabulary of machine-readable terms for tagging datasets with data use permissions and restrictions. Enables automated matching between data access requests and dataset consent conditions, facilitating compliant secondary use of controlled-access genomic data.',
    'https://www.ga4gh.org/product/data-use-ontology-duo/',
    (SELECT id FROM standard_type WHERE name = 'POLICY')
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'DUO'),
    '2021-02-23',
    'DUO release 2021-02-23 — approved GA4GH standard for data use terms, referenced by genomics repositories in over 15 countries'
) ON CONFLICT DO NOTHING;
