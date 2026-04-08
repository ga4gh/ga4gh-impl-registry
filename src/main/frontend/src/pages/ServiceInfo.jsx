import React from 'react'
import { api } from '../api'
import { useApi } from '../hooks/useApi'
import styles from './ServiceInfo.module.css'

export function ServiceInfo() {
  const { data, loading, error } = useApi(api.getServiceInfo)

  if (loading) return <div className={styles.loading}>Loading service info…</div>
  if (error)   return <div className={styles.error}>Failed to load service info: {error}</div>
  if (!data)   return null

  return (
    <div>
      <h2>Service Info</h2>
      <div className={styles.card}>
        <Row label="ID"            value={data.id} />
        <Row label="Name"          value={data.name} />
        <Row label="Description"   value={data.description} />
        <Row label="Version"       value={data.version} />
        <Row label="Environment"   value={data.environment} />
        <Row label="Type"          value={data.type} />
        <Row label="Organisation"  value={`${data.organisation?.name} — `} link={data.organisation?.url} />
        <Row label="Contact"       link={data.contactUrl} />
        <Row label="Documentation" link={data.documentationUrl} />
      </div>
    </div>
  )
}

function Row({ label, value, link }) {
  return (
    <div className={styles.row}>
      <strong>{label}</strong>
      <span>
        {value}
        {link && <a href={link} target="_blank" rel="noopener">{link}</a>}
      </span>
    </div>
  )
}
