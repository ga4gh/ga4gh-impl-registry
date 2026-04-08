import React, { useState, useEffect } from 'react'
import { EmailTagInput } from './EmailTagInput'
import styles from './ImplForm.module.css'

const ISO_ALPHA2 = new Set([
  'AF','AL','DZ','AD','AO','AG','AR','AM','AU','AT','AZ','BS','BH','BD','BB','BY','BE','BZ','BJ',
  'BT','BO','BA','BW','BR','BN','BG','BF','BI','CV','KH','CM','CA','CF','TD','CL','CN','CO','KM',
  'CD','CG','CR','HR','CU','CY','CZ','DK','DJ','DM','DO','EC','EG','SV','GQ','ER','EE','SZ','ET',
  'FJ','FI','FR','GA','GM','GE','DE','GH','GR','GD','GT','GN','GW','GY','HT','HN','HU','IS','IN',
  'ID','IR','IQ','IE','IL','IT','JM','JP','JO','KZ','KE','KI','KW','KG','LA','LV','LB','LS','LR',
  'LY','LI','LT','LU','MG','MW','MY','MV','ML','MT','MH','MR','MU','MX','FM','MD','MC','MN','ME',
  'MA','MZ','MM','NA','NR','NP','NL','NZ','NI','NE','NG','KP','MK','NO','OM','PK','PW','PS','PA',
  'PG','PY','PE','PH','PL','PT','QA','RO','RU','RW','KN','LC','VC','WS','SM','ST','SA','SN','RS',
  'SC','SL','SG','SK','SI','SB','SO','ZA','KR','SS','ES','LK','SD','SR','SE','CH','SY','TW','TJ',
  'TZ','TH','TL','TG','TO','TT','TN','TR','TM','TV','UG','UA','AE','GB','US','UY','UZ','VU','VA',
  'VE','VN','YE','ZM','ZW'
])

const EMPTY = {
  implementationId: '', name: '', description: '', url: '',
  implementationType: 'SERVICE', environment: '', curiePrefix: '',
  contactEmails: [], documentationUrl: '', serviceInfoUrl: '',
  organisationId: '', standardId: '', standardVersionId: '',
  geolocation: { latitude: '', longitude: '', country: '', city: '' },
  implData: null
}

export function ImplForm({ initial = EMPTY, standards = [], organisations = [], onSubmit, submitLabel = 'Register', error }) {
  const [f, setF] = useState(initial)
  const [versions, setVersions] = useState([])
  const [geoErrors, setGeoErrors] = useState({})

  // Reset form when initial changes (e.g. opening edit modal with new data)
  useEffect(() => { setF(initial); }, [initial])

  // When standard changes, update available versions
  useEffect(() => {
    const std = standards.find(s => s.id === f.standardId)
    setVersions(std?.versions || [])
    if (!std?.versions?.find(v => v.id === f.standardVersionId)) {
      setF(p => ({ ...p, standardVersionId: '' }))
    }
  }, [f.standardId, standards])

  const abbr = standards.find(s => s.id === f.standardId)?.abbreviation || ''
  const isDrs = abbr === 'DRS'
  const isWes = abbr === 'WES'
  const isTes = abbr === 'TES'
  const isTrs = abbr === 'TRS'

  function set(field, value) { setF(p => ({ ...p, [field]: value })) }
  function setGeo(field, value) { setF(p => ({ ...p, geolocation: { ...p.geolocation, [field]: value } })) }
  function setImplData(std, field, value) {
    setF(p => ({ ...p, implData: { ...p.implData, [std]: { ...(p.implData?.[std] || {}), [field]: value } } }))
  }

  function validateGeo() {
    const errs = {}
    const { latitude, longitude, country, city } = f.geolocation
    if (latitude !== '' && (isNaN(+latitude) || +latitude < -90 || +latitude > 90))
      errs.latitude = 'Must be between -90 and 90'
    if (longitude !== '' && (isNaN(+longitude) || +longitude < -180 || +longitude > 180))
      errs.longitude = 'Must be between -180 and 180'
    const c = country.toUpperCase()
    if (c && !ISO_ALPHA2.has(c)) errs.country = 'Must be a valid ISO 3166-1 alpha-2 code'
    const ci = city.toUpperCase()
    if (ci && !/^[A-Z]{2}-[A-Z0-9]+$/.test(ci)) errs.city = 'Must follow format CC-XXX (e.g. GB-CAM)'
    if (ci && c && !ci.startsWith(c + '-')) errs.city = `Must start with ${c}- (e.g. ${c}-XXX)`
    setGeoErrors(errs)
    return Object.keys(errs).length === 0
  }

  function buildImplData() {
    if (isDrs) return { drs: { objectsCount: +f.implData?.drs?.objectsCount || null, storageFootprintGb: +f.implData?.drs?.storageFootprintGb || null, hostingInfra: f.implData?.drs?.hostingInfra || null, queryConsent: f.implData?.drs?.queryConsent || false } }
    if (isWes) return { wes: { workflowsCount: +f.implData?.wes?.workflowsCount || null, workflowEngines: f.implData?.wes?.workflowEngines || null } }
    if (isTes) return { tes: { tasksCount: +f.implData?.tes?.tasksCount || null, computeAvailability: f.implData?.tes?.computeAvailability || null } }
    if (isTrs) return { trs: { workflowsCount: +f.implData?.trs?.workflowsCount || null, toolsCount: +f.implData?.trs?.toolsCount || null, notebooksCount: +f.implData?.trs?.notebooksCount || null } }
    return null
  }

  function handleSubmit(e) {
    e.preventDefault()
    if (!validateGeo()) return
    const geo = f.geolocation
    const hasGeo = geo.latitude || geo.longitude || geo.country
    onSubmit({
      implementationId: f.implementationId || null,
      name: f.name,
      description: f.description || null,
      url: f.url,
      implementationType: f.implementationType,
      environment: f.environment || null,
      curiePrefix: f.curiePrefix || null,
      contactEmails: f.contactEmails.length ? f.contactEmails : null,
      documentationUrl: f.documentationUrl || null,
      serviceInfoUrl: f.serviceInfoUrl || null,
      organisationId: f.organisationId,
      standardId: f.standardId,
      standardVersionId: f.standardVersionId,
      geolocation: hasGeo ? { latitude: +geo.latitude || null, longitude: +geo.longitude || null, country: geo.country.toUpperCase() || null, city: geo.city.toUpperCase() || null } : null,
      implData: buildImplData()
    })
  }

  return (
    <form onSubmit={handleSubmit} className={styles.form}>
      {error && <div className={styles.error}>{error}</div>}

      <div className={styles.divider}>Implementation Details</div>
      <div className={styles.row}>
        <div>
          <label>Implementation ID *</label>
          <input value={f.implementationId} onChange={e => set('implementationId', e.target.value)} placeholder="e.g. org.ga4gh.drs (domain reversed)" required />
        </div>
        <div>
          <label>Name *</label>
          <input value={f.name} onChange={e => set('name', e.target.value)} placeholder="e.g. EBI DRS Service" required />
        </div>
      </div>
      <div className={styles.row}>
        <div>
          <label>Type *</label>
          <select value={f.implementationType} onChange={e => set('implementationType', e.target.value)} required>
            <option value="SERVICE">Service</option>
            <option value="DEPLOYMENT">Deployment</option>
          </select>
        </div>
        <div>
          <label>Environment</label>
          <select value={f.environment} onChange={e => set('environment', e.target.value)}>
            <option value="">-- Select environment --</option>
            <option value="PRODUCTION">Production</option>
            <option value="DEVELOPMENT">Development</option>
            <option value="TEST">Test</option>
            <option value="OTHER">Other</option>
          </select>
        </div>
      </div>
      <div>
        <label>Base URL *</label>
        <input value={f.url} onChange={e => set('url', e.target.value)} type="url" placeholder="Base URL of your server" required />
      </div>
      <div>
        <label>Service Info URL</label>
        <input value={f.serviceInfoUrl} onChange={e => set('serviceInfoUrl', e.target.value)} type="url" placeholder="Service-info endpoint of server" />
      </div>
      <div>
        <label>Description</label>
        <textarea value={f.description} onChange={e => set('description', e.target.value)} placeholder="Description of this implementation" />
      </div>
      <div className={styles.row}>
        <div>
          <label>Documentation URL</label>
          <input value={f.documentationUrl} onChange={e => set('documentationUrl', e.target.value)} type="url" placeholder="https://..." />
        </div>
        <div>
          <label>CURIE Prefix</label>
          <input value={f.curiePrefix} onChange={e => set('curiePrefix', e.target.value)} placeholder="Powered by identifiers.org" />
        </div>
      </div>
      <div>
        <label>Contact Emails</label>
        <EmailTagInput emails={f.contactEmails} onChange={v => set('contactEmails', v)} />
      </div>

      <div className={styles.divider}>Standard</div>
      <div className={styles.row}>
        <div>
          <label>Standard *</label>
          <select value={f.standardId} onChange={e => set('standardId', e.target.value)} required>
            <option value="">-- Select standard --</option>
            {standards.map(s => <option key={s.id} value={s.id}>{s.name} ({s.abbreviation})</option>)}
          </select>
        </div>
        <div>
          <label>Version *</label>
          <select value={f.standardVersionId} onChange={e => set('standardVersionId', e.target.value)} required disabled={!versions.length}>
            <option value="">-- Select version --</option>
            {versions.map(v => <option key={v.id} value={v.id}>{v.version}</option>)}
          </select>
        </div>
      </div>

      {/* Standard-specific sections */}
      {isDrs && (
        <div className={styles.stdSection}>
          <div className={styles.divider}>DRS-Specific Details</div>
          <div className={styles.row}>
            <div>
              <label>Unique DRS Objects</label>
              <input type="number" min="0" value={f.implData?.drs?.objectsCount || ''} onChange={e => setImplData('drs','objectsCount',e.target.value)} placeholder="Total unique DRS objects" />
            </div>
            <div>
              <label>Storage Footprint (GB)</label>
              <input type="number" min="0" step="0.01" value={f.implData?.drs?.storageFootprintGb || ''} onChange={e => setImplData('drs','storageFootprintGb',e.target.value)} placeholder="Total non-duplicated storage in GB" />
            </div>
          </div>
          <div className={styles.row}>
            <div>
              <label>Hosting Infrastructure</label>
              <select value={f.implData?.drs?.hostingInfra || ''} onChange={e => setImplData('drs','hostingInfra',e.target.value)}>
                <option value="">-- Select hosting --</option>
                <option value="COMMERCIAL_CLOUD">Commercial Cloud</option>
                <option value="PRIVATE_CLOUD">Private Cloud</option>
                <option value="ON_PREMISES">On-premises / Dedicated local hardware</option>
              </select>
            </div>
            <div className={styles.checkRow}>
              <input type="checkbox" id="drs-consent" checked={f.implData?.drs?.queryConsent || false} onChange={e => setImplData('drs','queryConsent',e.target.checked)} />
              <label htmlFor="drs-consent" style={{fontWeight: 400}}>Consent for periodically querying service info</label>
            </div>
          </div>
        </div>
      )}
      {isWes && (
        <div className={styles.stdSection}>
          <div className={styles.divider}>WES-Specific Details</div>
          <div className={styles.row}>
            <div><label>Number of Workflows</label><input type="number" min="0" value={f.implData?.wes?.workflowsCount || ''} onChange={e => setImplData('wes','workflowsCount',e.target.value)} /></div>
            <div><label>Workflow Engines</label><input value={f.implData?.wes?.workflowEngines || ''} onChange={e => setImplData('wes','workflowEngines',e.target.value)} placeholder="e.g. Nextflow, Cromwell" /></div>
          </div>
        </div>
      )}
      {isTes && (
        <div className={styles.stdSection}>
          <div className={styles.divider}>TES-Specific Details</div>
          <div className={styles.row}>
            <div><label>Number of Tasks</label><input type="number" min="0" value={f.implData?.tes?.tasksCount || ''} onChange={e => setImplData('tes','tasksCount',e.target.value)} /></div>
            <div><label>Compute Availability</label><input value={f.implData?.tes?.computeAvailability || ''} onChange={e => setImplData('tes','computeAvailability',e.target.value)} placeholder="e.g. HPC, cloud, on-premises" /></div>
          </div>
        </div>
      )}
      {isTrs && (
        <div className={styles.stdSection}>
          <div className={styles.divider}>TRS-Specific Details</div>
          <div className={styles.row}>
            <div><label>Number of Workflows</label><input type="number" min="0" value={f.implData?.trs?.workflowsCount || ''} onChange={e => setImplData('trs','workflowsCount',e.target.value)} /></div>
            <div><label>Number of Tools</label><input type="number" min="0" value={f.implData?.trs?.toolsCount || ''} onChange={e => setImplData('trs','toolsCount',e.target.value)} /></div>
          </div>
          <div className={styles.row}>
            <div><label>Number of Notebooks</label><input type="number" min="0" value={f.implData?.trs?.notebooksCount || ''} onChange={e => setImplData('trs','notebooksCount',e.target.value)} /></div>
            <div />
          </div>
        </div>
      )}

      <div className={styles.divider}>Organisation</div>
      <div>
        <label>Organisation *</label>
        <select value={f.organisationId} onChange={e => set('organisationId', e.target.value)} required>
          <option value="">-- Select organisation --</option>
          {organisations.map(o => <option key={o.id} value={o.id}>{o.name}</option>)}
        </select>
      </div>

      <div className={styles.divider}>Geolocation (optional)</div>
      <div className={styles.row}>
        <div>
          <label>Latitude</label>
          <input type="number" step="any" value={f.geolocation.latitude} onChange={e => setGeo('latitude', e.target.value)} placeholder="e.g. 52.0797" className={geoErrors.latitude ? styles.invalid : ''} />
          {geoErrors.latitude && <span className={styles.fieldError}>{geoErrors.latitude}</span>}
        </div>
        <div>
          <label>Longitude</label>
          <input type="number" step="any" value={f.geolocation.longitude} onChange={e => setGeo('longitude', e.target.value)} placeholder="e.g. 0.1872" className={geoErrors.longitude ? styles.invalid : ''} />
          {geoErrors.longitude && <span className={styles.fieldError}>{geoErrors.longitude}</span>}
        </div>
      </div>
      <div className={styles.row}>
        <div>
          <label>Country <span className={styles.hint}><a href="https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2" target="_blank" rel="noopener">ISO 3166-1</a> alpha-2</span></label>
          <input maxLength={2} value={f.geolocation.country} onChange={e => setGeo('country', e.target.value.toUpperCase())} placeholder="e.g. GB" className={geoErrors.country ? styles.invalid : ''} />
          {geoErrors.country && <span className={styles.fieldError}>{geoErrors.country}</span>}
        </div>
        <div>
          <label>City Code <span className={styles.hint}><a href="https://en.wikipedia.org/wiki/ISO_3166-2" target="_blank" rel="noopener">ISO 3166-2</a></span></label>
          <input maxLength={10} value={f.geolocation.city} onChange={e => setGeo('city', e.target.value.toUpperCase())} placeholder="e.g. GB-CAM" className={geoErrors.city ? styles.invalid : ''} />
          {geoErrors.city && <span className={styles.fieldError}>{geoErrors.city}</span>}
        </div>
      </div>

      <div className={styles.actions}>
        <button type="submit" className={styles.btnPrimary}>{submitLabel}</button>
      </div>
    </form>
  )
}
