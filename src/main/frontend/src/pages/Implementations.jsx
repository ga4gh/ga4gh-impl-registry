import React, { useState, useContext, useCallback } from 'react'
import { api } from '../api'
import { useApi } from '../hooks/useApi'
import { EditModal } from '../components/EditModal'
import { ToastContext } from '../App'
import styles from './Implementations.module.css'

export function Implementations({ type }) {
  const isService   = type === 'SERVICE'
  const fetchFn     = useCallback(() => isService ? api.getServices() : api.getDeployments(), [isService])
  const { data, loading, error, refresh } = useApi(fetchFn, [type])

  const { data: standards }    = useApi(api.getStandards)
  const { data: organisations } = useApi(api.getOrganisations)

  const [editing, setEditing]     = useState(null)
  const [editError, setEditError] = useState(null)
  const showToast = useContext(ToastContext)

  async function handleSave(body) {
    setEditError(null)
    try {
      if (isService) await api.updateService(editing.id, body)
      else           await api.updateDeployment(editing.id, body)
      await refresh()
      setEditing(null)
      showToast(`${isService ? 'Service' : 'Deployment'} updated successfully.`)
    } catch (e) {
      setEditError(e.message)
    }
  }

  const title = isService ? 'Services' : 'Deployments'

  return (
    <div>
      <h2>{title}</h2>

      {loading && <div className={styles.loading}>Loading {title.toLowerCase()}…</div>}
      {error   && <div className={styles.error}>Failed to load {title.toLowerCase()}: {error}</div>}

      {!loading && !error && (
        !data?.length
          ? <div className={styles.empty}>No {title.toLowerCase()} registered yet</div>
          : <div className={styles.grid}>
              {data.map(d => (
                <ImplCard
                  key={d.id}
                  impl={d}
                  onEdit={() => { setEditError(null); setEditing(d) }}
                />
              ))}
            </div>
      )}

      {editing && (
        <EditModal
          impl={editing}
          standards={standards || []}
          organisations={organisations || []}
          onSave={handleSave}
          onClose={() => { setEditing(null); setEditError(null) }}
          error={editError}
        />
      )}
    </div>
  )
}

function ImplCard({ impl, onEdit }) {
  const { implData: id_, geolocation: geo } = impl
  const drs = id_?.drs
  const wes = id_?.wes
  const tes = id_?.tes
  const trs = id_?.trs
  const typeClass  = impl.implementationType === 'SERVICE' ? styles.tagService : styles.tagDeployment
  const ga4ghProduct = impl.standardVersion?.ga4ghProduct

  return (
    <div className={styles.card}>
      <div className={styles.cardTop}>
        <h4>{impl.name}</h4>
        <span className={`${styles.tag} ${typeClass}`}>{impl.implementationType}</span>
      </div>

      {impl.implementationId && <p><strong>ID:</strong> {impl.implementationId}</p>}
      {impl.description      && <p>{impl.description}</p>}

      <p><strong>URL:</strong> <a href={impl.url} target="_blank" rel="noopener">{impl.url}</a></p>
      <p><strong>Organisation:</strong> {impl.organisation?.name}</p>

      {/* GA4GH Product + version together */}
      {ga4ghProduct && (
        <p>
          <strong>GA4GH Product:</strong> {ga4ghProduct}
          {impl.standardVersion?.version && ` v${impl.standardVersion.version}`}
        </p>
      )}

      {impl.environment    && <p><strong>Environment:</strong> {impl.environment}</p>}
      {impl.serviceInfoUrl && <p><strong>Service Info:</strong> <a href={impl.serviceInfoUrl} target="_blank" rel="noopener">{impl.serviceInfoUrl}</a></p>}

      {impl.contactEmails?.length > 0 && (
        <p><strong>Contact:</strong> {impl.contactEmails.join(', ')}</p>
      )}

      {geo && (
        <p><strong>Location:</strong> {geo.city ? `${geo.city}, ` : ''}{geo.country}</p>
      )}

      {drs?.objectsCount      != null && <p><strong>DRS Objects:</strong> {drs.objectsCount.toLocaleString()}</p>}
      {drs?.storageFootprintGb != null && <p><strong>Storage:</strong> {drs.storageFootprintGb} GB</p>}
      {wes?.workflowEngines   && <p><strong>WES Engines:</strong> {wes.workflowEngines}</p>}
      {wes?.workflowsCount    != null && <p><strong>Workflows:</strong> {wes.workflowsCount.toLocaleString()}</p>}
      {tes?.tasksCount        != null && <p><strong>TES Tasks:</strong> {tes.tasksCount.toLocaleString()}</p>}
      {trs?.toolsCount        != null && <p><strong>TRS Tools:</strong> {trs.toolsCount.toLocaleString()}</p>}

      <button className={styles.editBtn} onClick={onEdit}>Edit</button>
    </div>
  )
}
