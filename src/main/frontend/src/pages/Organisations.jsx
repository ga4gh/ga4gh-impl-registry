import React, { useState, useContext } from 'react'
import { api } from '../api'
import { useApi } from '../hooks/useApi'
import { ToastContext } from '../App'
import styles from './Organisations.module.css'

export function Organisations() {
  const { data, loading, error, refresh } = useApi(api.getOrganisations)
  const showToast = useContext(ToastContext)

  const [form, setForm]     = useState({ orgId: '', name: '', shortName: '', url: '', description: '' })
  const [formError, setFormError] = useState(null)
  const [submitting, setSubmitting] = useState(false)

  function set(field, value) { setForm(p => ({ ...p, [field]: value })) }

  async function handleSubmit(e) {
    e.preventDefault()
    setFormError(null)
    setSubmitting(true)
    try {
      await api.createOrganisation({
        orgId:       form.orgId       || null,
        name:        form.name,
        shortName:   form.shortName   || null,
        url:         form.url         || null,
        description: form.description || null
      })
      await refresh()
      setForm({ orgId: '', name: '', shortName: '', url: '', description: '' })
      showToast('Organisation registered successfully.')
    } catch (e) {
      setFormError(e.message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div>
      <h2>Organisations</h2>

      {loading && <div className={styles.status}>Loading organisations…</div>}
      {error   && <div className={styles.error}>Failed to load organisations: {error}</div>}

      {!loading && !error && (
        !data?.length
          ? <div className={styles.status}>No organisations registered yet</div>
          : <div className={styles.grid}>
              {data.map(o => (
                <div key={o.id} className={styles.card}>
                  <h4>{o.name}</h4>
                  {o.orgId     && <p><strong>Org ID:</strong> {o.orgId}</p>}
                  {o.shortName && <p><strong>Short name:</strong> {o.shortName}</p>}
                  {o.description && <p>{o.description}</p>}
                  {o.url       && <p><strong>URL:</strong> <a href={o.url} target="_blank" rel="noopener">{o.url}</a></p>}
                </div>
              ))}
            </div>
      )}

      <div className={styles.formCard}>
        <h3>Register New Organisation</h3>
        {formError && <div className={styles.formError}>{formError}</div>}
        <form onSubmit={handleSubmit} className={styles.form}>
          <div className={styles.row}>
            <div>
              <label>Organisation ID *</label>
              <input value={form.orgId} onChange={e => set('orgId', e.target.value)} placeholder="e.g. org.ga4gh (URL reversed)" required />
            </div>
            <div>
              <label>Name *</label>
              <input value={form.name} onChange={e => set('name', e.target.value)} placeholder="e.g. European Bioinformatics Institute" required />
            </div>
          </div>
          <div className={styles.row}>
            <div>
              <label>Short Name</label>
              <input value={form.shortName} onChange={e => set('shortName', e.target.value)} placeholder="e.g. EMBL-EBI" />
            </div>
            <div>
              <label>Organisation URL</label>
              <input type="url" value={form.url} onChange={e => set('url', e.target.value)} placeholder="https://www.example.org" />
            </div>
          </div>
          <div>
            <label>Description</label>
            <textarea value={form.description} onChange={e => set('description', e.target.value)} placeholder="Description of the organisation" />
          </div>
          <button type="submit" className={styles.btnPrimary} disabled={submitting}>
            {submitting ? 'Registering…' : 'Register Organisation'}
          </button>
        </form>
      </div>
    </div>
  )
}
