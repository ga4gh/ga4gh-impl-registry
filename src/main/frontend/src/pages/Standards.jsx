import React from 'react'
import { api } from '../api'
import { useApi } from '../hooks/useApi'
import styles from './Standards.module.css'

export function Standards() {
  const { data, loading, error } = useApi(api.getStandards)

  if (loading) return <div className={styles.loading}>Loading standards…</div>
  if (error)   return <div className={styles.error}>Failed to load standards: {error}</div>

  return (
    <div>
      <h2>Standards</h2>
      {!data?.length
        ? <div className={styles.empty}>No standards found</div>
        : <div className={styles.grid}>
            {data.map(s => (
              <div key={s.id} className={styles.card}>
                <div className={styles.cardHeader}>
                  <strong>{s.name}</strong>
                  <span className={styles.tag}>{s.standardType}</span>
                </div>
                {s.abbreviation && <p><strong>Abbreviation:</strong> {s.abbreviation}</p>}
                {s.description  && <p>{s.description}</p>}
                {s.url && <p><a href={s.url} target="_blank" rel="noopener">{s.url}</a></p>}
                <div className={styles.versions}>
                  {(s.versions || []).map(v => (
                    <span key={v.id} className={styles.versionTag}>{v.version}</span>
                  ))}
                </div>
              </div>
            ))}
          </div>
      }
    </div>
  )
}
