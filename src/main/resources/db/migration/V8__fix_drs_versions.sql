-- V8__fix_drs_versions.sql
-- Removes DRS 1.3.0experimental, adds DRS 1.5.0 and 1.6.0,
-- and re-points any implementation using 1.3.0experimental to 1.3.0

-- Step 1: Re-point implementations using 1.3.0experimental to 1.3.0
UPDATE implementation
SET standard_version_id = (
    SELECT id FROM standard_version
    WHERE version = '1.3.0'
    AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')
)
WHERE standard_version_id = (
    SELECT id FROM standard_version
    WHERE version = '1.3.0experimental'
    AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS')
);

-- Step 2: Remove 1.3.0experimental now that no implementations reference it
DELETE FROM standard_version
WHERE version = '1.3.0experimental'
AND standard_id = (SELECT id FROM standard WHERE abbreviation = 'DRS');

-- Step 3: Add DRS 1.5.0
INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    '1.5.0',
    'DRS version 1.5.0'
) ON CONFLICT DO NOTHING;

-- Step 4: Add DRS 1.6.0
INSERT INTO standard_version (id, standard_id, version, description)
VALUES (
    gen_random_uuid(),
    (SELECT id FROM standard WHERE abbreviation = 'DRS'),
    '1.6.0',
    'DRS version 1.6.0'
) ON CONFLICT DO NOTHING;
