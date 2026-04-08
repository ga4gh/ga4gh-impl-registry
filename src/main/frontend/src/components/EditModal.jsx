import React, { useEffect, useState } from 'react'
import { ImplForm } from './ImplForm'
import styles from './EditModal.module.css'

function implToFormState(impl, standards) {
  if (!impl) return null
  const std = standards.find(s => s.versions?.some(v => v.id === impl.standardVersion?.id))
  const abbr = std?.abbreviation?.toLowerCase()
  return {
    implementationId: impl.implementationId || '',
    name: impl.name || '',
    description: impl.description || '',
    url: impl.url || '',
    implementationType: impl.implementationType || 'SERVICE',
    environment: impl.environment || '',
    curiePrefix: impl.curiePrefix || '',
    contactEmails: impl.contactEmails || [],
    documentationUrl: impl.documentationUrl || '',
    serviceInfoUrl: impl.serviceInfoUrl || '',
    organisationId: impl.organisation?.id || '',
    standardId: std?.id || '',
    standardVersionId: impl.standardVersion?.id || '',
    geolocation: {
      latitude:  impl.geolocation?.latitude  ?? '',
      longitude: impl.geolocation?.longitude ?? '',
      country:   impl.geolocation?.country   || '',
      city:      impl.geolocation?.city      || ''
    },
    implData: abbr ? { [abbr]: impl.implData?.[abbr] || {} } : null
  }
}

export function EditModal({ impl, standards, organisations, onSave, onClose, error }) {
  const [formKey, setFormKey] = useState(0)

  // Force ImplForm to re-mount with fresh state when impl changes
  useEffect(() => { setFormKey(k => k + 1) }, [impl?.id])

  if (!impl) return null

  const initial = implToFormState(impl, standards)

  return (
    <div className={styles.backdrop} onMouseDown={e => { if (e.target === e.currentTarget) onClose() }}>
      <div className={styles.modal}>
        <div className={styles.header}>
          <h3>Edit {impl.implementationType === 'SERVICE' ? 'Service' : 'Deployment'}</h3>
          <button className={styles.close} onClick={onClose} title="Close">×</button>
        </div>
        <div className={styles.body}>
          <ImplForm
            key={formKey}
            initial={initial}
            standards={standards}
            organisations={organisations}
            onSubmit={onSave}
            submitLabel="Save Changes"
            error={error}
          />
        </div>
      </div>
    </div>
  )
}
