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

const EMPTY = { orgId: '', name: '', shortName: '', url: '', description: '' }

export function Organisations() {
  const { data, loading, error, refresh } = useApi(api.getOrganisations)
  const showToast = useContext(ToastContext)

  const [query, setQuery]         = useState('')
  const [form, setForm]           = useState(EMPTY)
  const [formError, setFormError] = useState(null)
  const [submitting, setSubmitting] = useState(false)

  // Edit modal state
  const [editing, setEditing]     = useState(null)   // org object being edited
  const [editForm, setEditForm]   = useState(EMPTY)
  const [editError, setEditError] = useState(null)
  const [editSaving, setEditSaving] = useState(false)

  const filtered = data ? data.filter(o => matches(o, query)) : []

  function set(field, value) { setForm(p => ({ ...p, [field]: value })) }
  function setEdit(field, value) { setEditForm(p => ({ ...p, [field]: value })) }

  function openEdit(org) {
    setEditForm({
      orgId:       org.orgId       || '',
      name:        org.name        || '',
      shortName:   org.shortName   || '',
      url:         org.url         || '',
      description: org.description || ''
    })
    setEditError(null)
    setEditing(org)
  }

  function closeEdit() { setEditing(null); setEditError(null) }

  async function handleCreate(e) {
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
      setForm(EMPTY)
      showToast('Organisation registered successfully.')
    } catch (e) {
      setFormError(e.message)
    } finally {
      setSubmitting(false)
    }
  }

  async function handleUpdate(e) {
    e.preventDefault()
    setEditError(null)
    setEditSaving(true)
    try {
      await api.updateOrganisation(editing.id, {
        orgId:       editForm.orgId       || null,
        name:        editForm.name,
        shortName:   editForm.shortName   || null,
        url:         editForm.url         || null,
        description: editForm.description || null
      })
      await refresh()
      closeEdit()
      showToast('Organisation updated successfully.')
    } catch (e) {
      setEditError(e.message)
    } finally {
      setEditSaving(false)
    }
  }

  return (
    <div>
      <h2>Organisations</h2>

      {/* Search */}
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
                  {o.url && <p><strong>URL:</strong> <a href={o.url} target="_blank" rel="noopener">{o.url}</a></p>}
                  <button className={styles.editBtn} onClick={() => openEdit(o)}>Edit</button>
                </div>
              ))}
            </div>
      )}

      {/* Register form */}
      <div className={styles.formCard}>
        <h3>Register New Organisation</h3>
        {formError && <div className={styles.formError}>{formError}</div>}
        <form onSubmit={handleCreate} className={styles.form}>
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

      {/* Edit modal */}
      {editing && (
        <div
          className={styles.modalBackdrop}
          onMouseDown={e => { if (e.target === e.currentTarget) closeEdit() }}
        >
          <div className={styles.modal}>
            <div className={styles.modalHeader}>
              <h3>Edit Organisation</h3>
              <button className={styles.modalClose} onClick={closeEdit} title="Close">×</button>
            </div>
            <div className={styles.modalBody}>
              {editError && <div className={styles.formError}>{editError}</div>}
              <form onSubmit={handleUpdate} className={styles.form}>
                <div className={styles.row}>
                  <div>
                    <label>Organisation ID *</label>
                    <input value={editForm.orgId} onChange={e => setEdit('orgId', e.target.value)} placeholder="e.g. org.ga4gh" required />
                  </div>
                  <div>
                    <label>Name *</label>
                    <input value={editForm.name} onChange={e => setEdit('name', e.target.value)} required />
                  </div>
                </div>
                <div className={styles.row}>
                  <div>
                    <label>Short Name</label>
                    <input value={editForm.shortName} onChange={e => setEdit('shortName', e.target.value)} />
                  </div>
                  <div>
                    <label>Organisation URL</label>
                    <input type="url" value={editForm.url} onChange={e => setEdit('url', e.target.value)} placeholder="https://..." />
                  </div>
                </div>
                <div>
                  <label>Description</label>
                  <textarea value={editForm.description} onChange={e => setEdit('description', e.target.value)} />
                </div>
                <div className={styles.modalActions}>
                  <button type="submit" className={styles.btnPrimary} disabled={editSaving}>
                    {editSaving ? 'Saving…' : 'Save Changes'}
                  </button>
                  <button type="button" className={styles.btnSecondary} onClick={closeEdit}>
                    Cancel
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
