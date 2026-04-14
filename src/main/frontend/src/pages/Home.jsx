import React from 'react'
import { useNavigate } from 'react-router-dom'
import styles from './Home.module.css'

const NAV_ITEMS = [
  {
    path: '/services',
    label: 'Services',
    icon: '🖥️',
    description:
      'Browse running web servers that serve genomic data according to a GA4GH API specification. Each service is a live, queryable endpoint.'
  },
  {
    path: '/deployments',
    label: 'Deployments',
    icon: '📦',
    description:
      'Browse codebases and tools that implement one or more GA4GH standards — including client libraries, command-line tools, and server implementations that can be spun up.'
  },
  {
    path: '/organisations',
    label: 'Organisations',
    icon: '🏛️',
    description:
      'Browse the organisations that have registered services or deployments in this registry.'
  },
  {
    path: '/standards',
    label: 'Standards',
    icon: '📋',
    description:
      'View the GA4GH standards tracked by this registry, including DRS, WES, TES, TRS, htsget, refget, and Sequence Collections.'
  },
  {
    path: '/register',
    label: 'Register',
    icon: '✏️',
    description:
      'Register a new service or deployment implementation. All submissions are manually curated by the GA4GH team before appearing in the registry.'
  }
]

export function Home() {
  const navigate = useNavigate()

  return (
    <div className={styles.page}>

      {/* Curation banner */}
      <div className={styles.curationBanner}>
        <span className={styles.bannerIcon}>ℹ️</span>
        <span>
          All data in the Implementation Registry will be manually curated
          before being made available in the Service Registry.
        </span>
      </div>

      {/* Hero */}
      <div className={styles.hero}>
        <h2 className={styles.heroTitle}>GA4GH Implementation Registry</h2>
        <p className={styles.heroSubtitle}>
          A community registry of services, deployments, and tools that implement
          GA4GH Cloud API standards — including DRS, WES, TES, TRS, htsget, refget,
          and Sequence Collections.
        </p>
      </div>

      {/* Navigation guide */}
      <h3 className={styles.sectionTitle}>Explore the Registry</h3>
      <div className={styles.navGrid}>
        {NAV_ITEMS.map(item => (
          <button
            key={item.path}
            className={styles.navCard}
            onClick={() => navigate(item.path)}
          >
            <span className={styles.navIcon}>{item.icon}</span>
            <span className={styles.navLabel}>{item.label}</span>
            <span className={styles.navDesc}>{item.description}</span>
          </button>
        ))}
      </div>

    </div>
  )
}
