import React, { useState, useContext } from 'react'
import { api } from '../api'
import { useApi } from '../hooks/useApi'
import { ToastContext } from '../App'
import styles from './Organisations.module.css'

function matches(org, query) {
  if (!query) return true
  const q = query.toLowerCase()
  return (
    org.name?.toLowerCase().includes(q) ||
    org.orgId?.toLowerCase().includes(q) ||
    org.shortName?.toLowerCase().includes(q)
  )
}

export function Organisations() {
  const { data, loading, error, refresh } = useApi(api.getOrganisations)
  const showToast = useContext(ToastContext)

  const [form, setForm]       = useState({ orgId: '', name: '', shortName: '', url: '', description: '' })
  const [formError, setFormError] = useState(null)
  const [submitting, setSubmitting] = useState(false)
  const [query, setQuery]     = useState('')

  const filtered = data ? data.filter(o => matches(o, query)) : []

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

      {/* Search box */}
      <div className={styles.searchRow}>
        <input
          className={styles.searchInput}
          type="text"
          placeholder="Search by name, organisation ID or short name…"
          value={query}
          onChange={e => setQuery(e.target.value)}
        />
        {query && (
          <button className={styles.clearBtn} onClick={() => setQuery('')} title="Clear">×</button>
        )}
      </div>

      {loading && <div className={styles.status}>Loading organisations…</div>}
      {error   && <div className={styles.error}>Failed to load organisations: {error}</div>}

      {!loading && !error && (
        filtered.length === 0
          ? <div className={styles.status}>
              {data?.length === 0 ? 'No organisations registered yet' : `No results match "${query}"`}
            </div>
          : <div className={styles.grid}>
              {filtered.map(o => (
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
