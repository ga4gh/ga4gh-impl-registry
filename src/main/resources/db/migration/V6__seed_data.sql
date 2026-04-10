-- V6__seed_data.sql
-- Auto-generated from Implementations.xlsx

-- ═══════════════════════════════════════════════════
-- 1. NEW STANDARDS (htsget, refget)
-- ═══════════════════════════════════════════════════

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(), 'HTS Get', 'htsget', 'HTS Get API standard', 'https://samtools.github.io/hts-specs/htsget.html',
    (SELECT id FROM standard_type WHERE name = 'API')
) ON CONFLICT DO NOTHING;

INSERT INTO standard (id, name, abbreviation, description, url, standard_type_id)
VALUES (
    gen_random_uuid(), 'Refget', 'refget', 'Refget API standard', 'https://samtools.github.io/hts-specs/refget.html',
    (SELECT id FROM standard_type WHERE name = 'API')
) ON CONFLICT DO NOTHING;

-- ═══════════════════════════════════════════════════
-- 2. NEW STANDARD VERSIONS
-- ═══════════════════════════════════════════════════

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    '1.3.0',
    'DRS version 1.3.0'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    '1.3.0experimental',
    'DRS version 1.3.0experimental'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    '1.4.0',
    'DRS version 1.4.0'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'htsget'),
    '1.2.0',
    'htsget version 1.2.0'
) ON CONFLICT DO NOTHING;

INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'refget'),
    '1.0.0',
    'refget version 1.0.0'
) ON CONFLICT DO NOTHING;

-- ═══════════════════════════════════════════════════
-- 3. ORGANISATIONS
-- ═══════════════════════════════════════════════════

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Bloodpac', 'org.bloodpac.data', 'https://data.bloodpac.org', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Center For Translational Data Science', 'org.cancinedc', 'https://caninedc.org/', 'CTDS')
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Velsera', 'com.sb.cgc', 'https://velsera.com/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Velsera', 'com.sb.cavatica', 'https://velsera.com/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Velsera', 'com.sb.bdc', 'https://velsera.com/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Canine Data Commons', 'org.caninedc', 'https://caninedc.org', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Chicagoland Covid-19 Commons', 'org.pandemicresponsecommons.chicagoland', 'https://chicagoland.pandemicresponsecommons.org/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'ICGC PCAWG & DREAM Challenge', 'org.bionimbus.icgc', 'https://icgc.bionimbus.org/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Justice Community Opioid Innovation Network (JCOIN)', 'io.datacommons.jcoin', 'https://jcoin.datacommons.io/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Medical Imaging and Data Resoure Center', 'org.midrc.data', 'https://data.midrc.org', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'NCI CRDC', 'io.datacommons.nci-crdc', 'https://nci-crdc.datacommons.io/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Gen3 Data Hub', 'io.datacommons.gen3', 'https://gen3.datacommons.io/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Veterans Precision Oncology Data Commons', 'org.data-commons.vpodc', 'https://vpodc.data-commons.org/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'dbGaP at NCBI/NLM/NIH', 'gov.nih.nlm.ncbi', 'https://locate.be-md.ncbi.nlm.nih.gov/ga4gh/drs/v1/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'NHGRI AnVIL', 'org.anvilproject', 'https://anvilproject.org/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Sage Bionetworks', 'org.sagebase', 'https://sagebionetworks.org', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Human Cell Atlas', 'org.humancellatlas', 'https://www.humancellatlas.org/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'LungMAP', 'net.lungmap', 'https://www.lungmap.net/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Broad Institute of MIT and Harvard', 'org.broadinstitute', 'https://www.broadinstitute.org/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'DNAstack', 'com.dnastack', 'https://dnastack.com/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'EMBL European Bioinformatics Institute', 'uk.ac.ebi', 'https://www.ebi.ac.uk/', 'EMBL-EBI')
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'NHS Genomic Medicine Service / Genomics England', 'uk.nhs.service.api', 'https://www.genomicsengland.co.uk/', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO organisation (id, name, org_id, url, short_name)
VALUES (gen_random_uuid(), 'Global Alliance for Genomics and Health', 'org.ga4gh', 'https://ga4gh.org', 'GA4GH')
ON CONFLICT DO NOTHING;

-- ═══════════════════════════════════════════════════
-- 4. GEOLOCATIONS (deduplicated)
-- ═══════════════════════════════════════════════════

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('e8d3d579-50ec-4d8c-b342-50bdc22726fd', 41.8832, 87.6324, 'US-IL', 'US')
ON CONFLICT DO NOTHING;

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('10bb8aa3-2b45-4862-aa1e-8c123b790519', 37.538, -77.462, 'US-VA', 'US')
ON CONFLICT DO NOTHING;

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('daf450e8-ce7d-446b-afc6-5ab54c05f67a', 39.0006, -77.1031, 'US-MD', 'US')
ON CONFLICT DO NOTHING;

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('092abd17-216f-4bc0-96ee-523baef3dec4', 42.3638, 71.0866, 'US-MA', 'US')
ON CONFLICT DO NOTHING;

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('b0483317-d789-4adb-9034-181efa072ccd', 47.6181521107755, -122.351619073343, 'US-WA', 'US')
ON CONFLICT DO NOTHING;

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('c4588365-e01b-45c2-abae-395a23e6c0a4', 52.0799137396242, 0.186977123513518, 'GB-CAM', 'GB')
ON CONFLICT DO NOTHING;

INSERT INTO geolocation (id, latitude, longitude, city, country)
VALUES ('26786949-fdd4-434f-ae34-dd7551d16ae3', 51.5049, 0.0195, 'GB-ENG', 'GB')
ON CONFLICT DO NOTHING;

-- ═══════════════════════════════════════════════════
-- 5. IMPLEMENTATIONS + STANDARD-SPECIFIC DATA
-- ═══════════════════════════════════════════════════

-- org.bloodpac.data.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.bloodpac.data.drs',
    'Bloodpac',
    'SERVICE',
    NULL,
    'https://data.bloodpac.org/ga4gh/drs/v1/objects/',
    'https://data.bloodpac.org/ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS server',
    'https://github.com/uc-cdis/indexd',
    'dg.5B0D',
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.bloodpac.data'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.bloodpac.data.drs'),
    36667.0,
    41490,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.caninedc.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.caninedc.drs',
    'Canine Data Commons',
    'SERVICE',
    'PRODUCTION',
    'https://caninedc.org/ga4gh/drs/v1/objects/',
    'https://caninedc.org/ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS service',
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.C78ne',
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.cancinedc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.caninedc.drs'),
    3820.0,
    1880.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- com.sb.cgc.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'com.sb.cgc.drs',
    'Cancer Genomics Cloud DRS API',
    'SERVICE',
    'PRODUCTION',
    'https://cgc-ga4gh-api.sbgenomics.com',
    'https://cgc-ga4gh-api.sbgenomics.com/ga4gh/drs/v1/service-info',
    'Cancer Genomics Cloud DRS server',
    'https://docs.cancergenomicscloud.org/docs/drs-api-overview',
    'sbcgc',
    'surya.saha@velsera.com',
    (SELECT id FROM organisation WHERE org_id = 'com.sb.cgc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '10bb8aa3-2b45-4862-aa1e-8c123b790519'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'com.sb.cgc.drs'),
    17855440.0,
    73115600.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- com.sb.cavatica.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'com.sb.cavatica.drs',
    'Cavatica DRS API',
    'SERVICE',
    'PRODUCTION',
    'https://cavatica-ga4gh-api.sbgenomics.com',
    'https://cavatica-ga4gh-api.sbgenomics.com/ga4gh/drs/v1/service-info',
    'Cavatica DRS server',
    'https://docs.cavatica.org/reference/drs-api-overview',
    'sbcav',
    'surya.saha@velsera.com',
    (SELECT id FROM organisation WHERE org_id = 'com.sb.cavatica'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '10bb8aa3-2b45-4862-aa1e-8c123b790519'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'com.sb.cavatica.drs'),
    11475637.0,
    54198370.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- com.sb.bdc.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'com.sb.bdc.drs',
    'BioData Catalyst powered by Seven Bridges DRS API',
    'SERVICE',
    'PRODUCTION',
    'https://ga4gh-api.sb.biodatacatalyst.nhlbi.nih.gov',
    'https://ga4gh-api.sb.biodatacatalyst.nhlbi.nih.gov/ga4gh/drs/v1/service-info',
    'BioData Catalyst powered by Seven Bridges DRS server',
    'https://sb-biodatacatalyst.readme.io/reference/drs-api',
    'sbbdc',
    'surya.saha@velsera.com',
    (SELECT id FROM organisation WHERE org_id = 'com.sb.bdc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '10bb8aa3-2b45-4862-aa1e-8c123b790519'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'com.sb.bdc.drs'),
    28739258.0,
    67297760.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.caninedc.org
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.caninedc.org',
    'Canine Data Commons',
    'SERVICE',
    'PRODUCTION',
    'https://caninedc.org/ga4gh/drs/v1/objects/',
    'https://caninedc.org/ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS server',
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.C78ne',
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.caninedc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.caninedc.org'),
    3820.0,
    1880.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.pandemicresponsecommons.chicagoland.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.pandemicresponsecommons.chicagoland.drs',
    'Chicagoland Covid-19 Commons',
    'SERVICE',
    'PRODUCTION',
    'https://chicagoland.pandemicresponsecommons.org/ga4gh/drs/v1/objects',
    'https://chicagoland.pandemicresponsecommons.org/ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS Server',
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.63D5',
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.pandemicresponsecommons.chicagoland'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.pandemicresponsecommons.chicagoland.drs'),
    285849.0,
    117640.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.bionimbus.icgc.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.bionimbus.icgc.drs',
    'ICGC PCAWG & DREAM Challenge',
    'SERVICE',
    'PRODUCTION',
    'https://icgc.bionimbus.org/ga4gh/drs/v1/objects/',
    'https://icgc.bionimbus.org//ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS server',
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    NULL,
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.bionimbus.icgc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.bionimbus.icgc.drs'),
    100247.0,
    264420.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- io.datacommons.jcoin.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'io.datacommons.jcoin.drs',
    'Justice Community Opioid Innovation Network (JCOIN)',
    'SERVICE',
    'PRODUCTION',
    'https://jcoin.datacommons.io/ga4gh/drs/v1/objects/',
    'https://jcoin.datacommons.io/ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS server',
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.6VTS',
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'io.datacommons.jcoin'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'io.datacommons.jcoin.drs'),
    481.0,
    2.37,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.midrc.data.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.midrc.data.drs',
    'Medical Imaging and Data Resoure Center',
    'SERVICE',
    'PRODUCTION',
    'https://data.midrc.org/ga4gh/drs/v1/objects',
    'https://data.midrc.org/ga4gh/drs/v1/service-info',
    'Gen3 IndexD DRS server',
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.MD1R',
    'mlukowski@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.midrc.data'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.midrc.data.drs'),
    621360.0,
    12050.0,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- io.datacommons.nci-crdc.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'io.datacommons.nci-crdc.drs',
    'NCI CRDC',
    'SERVICE',
    'PRODUCTION',
    'https://nci-crdc.datacommons.io/',
    'https://nci-crdc.datacommons.io/ga4gh/drs/v1/service-info',
    NULL,
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.4DFC',
    'binamb@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'io.datacommons.nci-crdc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'io.datacommons.nci-crdc.drs'),
    58960177.0,
    16772079.45,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- io.datacommons.gen3.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'io.datacommons.gen3.drs',
    'Gen3 Data Hub',
    'SERVICE',
    'PRODUCTION',
    'https://gen3.datacommons.io/',
    'https://gen3.datacommons.io/ga4gh/drs/v1/service-info',
    NULL,
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.C78ne',
    'binamb@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'io.datacommons.gen3'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'io.datacommons.gen3.drs'),
    2376.0,
    14249.29,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.data-commons.vpodc.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.data-commons.vpodc.drs',
    'Veterans Precision Oncology Data Commons',
    'SERVICE',
    'PRODUCTION',
    'https://vpodc.data-commons.org/',
    'https://vpodc.data-commons.org/ga4gh/drs/v1/service-info',
    NULL,
    'https://gen3.org/resources/user/access-data/#access-data-from-the-data-commons-website',
    'dg.F738',
    'binamb@uchicago.edu',
    (SELECT id FROM organisation WHERE org_id = 'org.data-commons.vpodc'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'e8d3d579-50ec-4d8c-b342-50bdc22726fd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.data-commons.vpodc.drs'),
    352786.0,
    2184.86,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- gov.nih.nlm.ncbi.drs
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'gov.nih.nlm.ncbi.drs',
    'NCBI Data Repository Service',
    'SERVICE',
    'PRODUCTION',
    'https://locate.be-md.ncbi.nlm.nih.gov/ga4gh/drs/v1/',
    'https://locate.be-md.ncbi.nlm.nih.gov/ga4gh/drs/v1/service-info',
    'The NCBI DRS server can serve the 5 million+ sequences available in dbGaP studies. Beyond dbGaP, this server can also serve any DRS ID obtained from the NCBI ID Exchange service (https://locate.be-md.ncbi.nlm.nih.gov/idx/v1/
) when you input accessions for sequence runs (SRR#, ERR#, DRR#), sequence experiments (SRX#, ERX#, DRX#), or studies (SRP#, ERP#, DRP#).  SRR/SRX/SRP are accessions from the NCBI Sequence Read Archive (SRA); ERR/ERX/ERP are accessions from the European Nucleotide Archive (ENA); and DRR/DRX/DRP are accessions from the DNA Data Bank of Japan (DDBJ).

Please note that many DRS_ID from SRR accessions provide multiple DRS_IDs for multiple file formats (SRA, SRA Lite, BAM, CRAM, or FASTQ). For example, https://locate.be-md.ncbi.nlm.nih.gov/ga4gh/drs/v1/objects/639b7f416001a8726edad74a5502002f gives three DRS_IDs for SRA, SRA Lite and cram format.  Only SRA and SRA Lite are in hot storage.  SRA or SRA Lite files can be converted to FASTQ using SRA samtool.  If you need direct access to FASTQ, BAM or cram formats, you should submit a cloud delivery request by following the instructions here: https://www.ncbi.nlm.nih.gov/sra/docs/data-delivery/
.

In addition to the production DRS server, we will also be setting up a development instance to support future DRS enhancements, including access to VCF, MAF, and image files in the upcoming fiscal year. Further details will be provided when available.',
    NULL,
    'https://registry.identifiers.org/registry/ncbidrs',
    'ward@ncbi.nlm.nih.gov',
    (SELECT id FROM organisation WHERE org_id = 'gov.nih.nlm.ncbi'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'daf450e8-ce7d-446b-afc6-5ab54c05f67a'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'gov.nih.nlm.ncbi.drs'),
    5.6,
    26,
    'ON_PREMISES',
    true
) ON CONFLICT DO NOTHING;

-- bio.terra.data.anvil
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'bio.terra.data.anvil',
    'NHGRI AnVIL',
    'SERVICE',
    'PRODUCTION',
    'https://data.terra.bio/',
    'https://data.terra.bio/ga4gh/drs/v1/service-info',
    'Provides GA4GH Data Repository Service (DRS) access to the USA National Institutes of Health (NIH), National Human Genome Research Institute (NHGRI),
Genomic Analysis, Visualization and Informatics Lab-space (AnVIL) data.

AnVIL is a cloud-based genomic data sharing and analysis platform that facilitates integration and computing on and across large datasets generated by NHGRI programs, as well as initiatives funded by the National Institutes of Health (NIH) or by other agencies that support human genomics research.',
    'https://anvilproject.org/learn/find-data/requesting-data-access',
    'drs.anv0',
    'mbaumann@broadinstitute.org',
    (SELECT id FROM organisation WHERE org_id = 'org.anvilproject'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '092abd17-216f-4bc0-96ee-523baef3dec4'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'bio.terra.data.anvil'),
    2.7,
    5939000,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- org.sagebase.prod.repo-prod
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.sagebase.prod.repo-prod',
    'Sage Bionetworks Synapse DRS API',
    'SERVICE',
    'PRODUCTION',
    'https://repo-prod.prod.sagebase.org/ga4gh/drs/v1/objects/',
    'https://repo-prod.prod.sagebase.org/ga4gh/drs/v1/service-info',
    'The Synpase DRS service is provides our entire biomedical data repository via a GA4GH DRS v1.2.0 compliant endpoints',
    'https://rest-docs.synapse.org/rest/#org.sagebionetworks.drs.controller.DrsController',
    'synapse',
    'susheel.varma@sagebase.org',
    (SELECT id FROM organisation WHERE org_id = 'org.sagebase'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'b0483317-d789-4adb-9034-181efa072ccd'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'org.sagebase.prod.repo-prod'),
    3.67,
    3.67,
    'COMMERCIAL_CLOUD',
    false
) ON CONFLICT DO NOTHING;

-- bio.terra.data.hca
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'bio.terra.data.hca',
    'Human Cell Atlas',
    'SERVICE',
    'PRODUCTION',
    'https://data.terra.bio/',
    'https://data.terra.bio/ga4gh/drs/v1/service-info',
    'The Human Cell Atlas is an international collaborative consortium that is creating a comprehensive, diverse and high-resolution molecular map of the human body, charting the cell types in the healthy body, across time from development to adulthood, and eventually to old age.',
    'https://data.humancellatlas.org/guides/requesting-access-to-controlled-access-data',
    'data.terra.bio (hostname only)',
    'mbaumann@broadinstitute.org',
    (SELECT id FROM organisation WHERE org_id = 'org.humancellatlas'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '092abd17-216f-4bc0-96ee-523baef3dec4'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'bio.terra.data.hca'),
    583100.0,
    314850,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- bio.terra.data.lungmap
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'bio.terra.data.lungmap',
    'LungMAP',
    'SERVICE',
    'PRODUCTION',
    'https://data.terra.bio/',
    'https://data.terra.bio/ga4gh/drs/v1/service-info',
    'The National Heart, Lung, and Blood Institute is funding an effort to create a molecular atlas of the developing lung (LungMAP) to serve as a research resource and public education tool.',
    'https://www.lungmap.net/resources-2/data-access-policy/',
    'data.terra.bio (hostname only)',
    'mbaumann@broadinstitute.org',
    (SELECT id FROM organisation WHERE org_id = 'net.lungmap'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '092abd17-216f-4bc0-96ee-523baef3dec4'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'bio.terra.data.lungmap'),
    4700.0,
    14150,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- bio.terra.data.broad
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'bio.terra.data.broad',
    'Broad Institute',
    'SERVICE',
    'PRODUCTION',
    'https://data.terra.bio/',
    'https://data.terra.bio/ga4gh/drs/v1/service-info',
    'Provides GA4GH Data Repository Service (DRS) access to data made available by the Broad Institute.

The Broad Institute is an independent, non-profit research organization that aims to discover the root causes of all common and rare diseases, and to use this insight to help develop safe and effective therapeutic interventions.',
    'https://support.terra.bio/hc/en-us/articles/4407244408347',
    'data.terra.bio (hostname only)',
    'mbaumann@broadinstitute.org',
    (SELECT id FROM organisation WHERE org_id = 'org.broadinstitute'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '092abd17-216f-4bc0-96ee-523baef3dec4'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'bio.terra.data.broad'),
    NULL,
    NULL,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- ai.viral
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'ai.viral',
    'Viral AI',
    'SERVICE',
    'PRODUCTION',
    'https://viral.ai',
    NULL,
    'Viral AI is a global network for genomic surveillance and infectious disease research.',
    'https://docs.omics.ai/products/command-line-interface/usage-examples',
    NULL,
    'max@dnastack.com',
    (SELECT id FROM organisation WHERE org_id = 'com.dnastack'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.0.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    NULL
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'ai.viral'),
    11.7,
    NULL,
    'COMMERCIAL_CLOUD',
    true
) ON CONFLICT DO NOTHING;

-- http://10.42.28.180:4500
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'http://10.42.28.180:4500',
    'DRS @ EBI',
    'SERVICE',
    'DEVELOPMENT',
    'http://10.42.28.180:4500',
    'http://10.42.28.180:4500/ga4gh/drs/v1/service-info',
    'DRS @ EBI is currently hosted internally on EMBL-EBI Infrastructure and is designed to manage access to Controlled Access Data (CAD) in accordance with EMBL-EBI’s institutional policies. The server is still in the development stage and does not yet include any authentication or authorization mechanisms, so at present it functions as a plain DRS (Data Repository Service) server. We have indexed approximately 200,000 human genome sequencing CRAM files from the UK Biobank Controlled Access Dataset. Additionally, we hosted 1000 Genomes Project data from IGSR, for which we have indexed two specific populations. Our goal is to enhance interoperability in future iterations by incorporating additional GA4GH standards.',
    NULL,
    NULL,
    'dashrath@ebi.ac.uk',
    (SELECT id FROM organisation WHERE org_id = 'uk.ac.ebi'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.3.0experimental' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    'c4588365-e01b-45c2-abae-395a23e6c0a4'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'http://10.42.28.180:4500'),
    200000,
    NULL,
    'ON_PREMISES',
    true
) ON CONFLICT DO NOTHING;

-- api.service.nhs.uk/genomic-data-access
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'api.service.nhs.uk/genomic-data-access',
    'NHS Genomic Data Access & Management',
    'SERVICE',
    'DEVELOPMENT',
    'https://sandbox.api.service.nhs.uk/genomic-data-access',
    'https://sandbox.api.service.nhs.uk/genomic-data-access/ga4gh/drs/v1.4/service-info',
    'NHS GMS DRS server, only available to NHS organisations',
    'https://digital.nhs.uk/developer/api-catalogue/genomic-data-access-and-management',
    NULL,
    'graham.ritchie@genomicsengland.co.uk',
    (SELECT id FROM organisation WHERE org_id = 'uk.nhs.service.api'),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    (SELECT id FROM standard_version WHERE version = '1.4.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')),
    '26786949-fdd4-434f-ae34-dd7551d16ae3'
) ON CONFLICT DO NOTHING;

INSERT INTO drs_data (id, implementation_id, objects_count, storage_footprint_gb, hosting_infra, query_consent)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM implementation WHERE implementation_id = 'api.service.nhs.uk/genomic-data-access'),
    NULL,
    NULL,
    'COMMERCIAL_CLOUD',
    false
) ON CONFLICT DO NOTHING;

-- org.dockstore
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.dockstore',
    'Dockstore',
    'SERVICE',
    'PRODUCTION',
    'https://dockstore.org/',
    NULL,
    'Dockstore is a free and open source platform for sharing reusable and scalable analytical tools and workflows.',
    'https://docs.dockstore.org/en/stable/dockstore-introduction.html',
    NULL,
    NULL,
    (SELECT id FROM organisation WHERE org_id = 'org.broadinstitute'),
    (SELECT id FROM standard WHERE abbreviation = 'TRS'),
    (SELECT id FROM standard_version WHERE version = '2.1.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'TRS')),
    NULL
) ON CONFLICT DO NOTHING;

-- org.ga4gh.htsget-refserver
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.ga4gh.htsget-refserver',
    'htsget Reference Server',
    'DEPLOYMENT',
    'DEVELOPMENT',
    'https://github.com/ga4gh/htsget-refserver',
    NULL,
    'Reference server implementation of the htsget API protocol for securely streaming genomic data.',
    'https://github.com/ga4gh/htsget-refserver',
    NULL,
    'ga4gh-tech-team@ga4gh.org',
    (SELECT id FROM organisation WHERE org_id = 'org.ga4gh'),
    (SELECT id FROM standard WHERE abbreviation = 'htsget'),
    (SELECT id FROM standard_version WHERE version = '1.2.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'htsget')),
    NULL
) ON CONFLICT DO NOTHING;

-- org.ga4gh.refget-cloud
INSERT INTO implementation (
    id, implementation_id, name, implementation_type, environment,
    url, service_info_url, description, documentation_url,
    curie_prefix, contact_email, organisation_id,
    standard_id, standard_version_id, geolocation_id
) VALUES (
    gen_random_uuid(),
    'org.ga4gh.refget-cloud',
    'Refget Cloud codebase',
    'DEPLOYMENT',
    'DEVELOPMENT',
    'https://github.com/ga4gh/refget-cloud',
    NULL,
    'Configurable, python-based Refget web service. Can be configured to run in multiple deployment contexts (e.g. containerized server, serverless) and serve data from multiple cloud-based sources.',
    'https://github.com/ga4gh/refget-cloud',
    NULL,
    'ga4gh-tech-team@ga4gh.org',
    (SELECT id FROM organisation WHERE org_id = 'org.ga4gh'),
    (SELECT id FROM standard WHERE abbreviation = 'refget'),
    (SELECT id FROM standard_version WHERE version = '1.0.0' AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'refget')),
    NULL
) ON CONFLICT DO NOTHING;
