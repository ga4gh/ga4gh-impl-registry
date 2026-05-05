import React from 'react'
import { useNavigate } from 'react-router-dom'
import styles from './Home.module.css'

const NAV_ITEMS = [
  {
    path: '/services',
    label: 'Services',
    icon: '🖥️',
    description: 'Browse running web servers serving genomic data according to a GA4GH API specification.'
  },
  {
    path: '/deployments',
    label: 'Deployments',
    icon: '📦',
    description: 'Browse codebases and tools that implement one or more GA4GH standards — client libraries, CLIs, and server implementations.'
  },
  {
    path: '/organisations',
    label: 'Organisations',
    icon: '🏛️',
    description: 'Browse the organisations that have registered services or deployments in this registry.'
  },
  {
    path: '/standards',
    label: 'Standards',
    icon: '📋',
    description: 'View the GA4GH standards tracked here, including DRS, WES, TES, TRS, htsget, refget, Beacon and more.'
  },
  {
    path: '/register',
    label: 'Register',
    icon: '✏️',
    description: 'Register a new service or deployment. All submissions are manually curated by the GA4GH team before appearing here.'
  }
]

export function Home() {
  const navigate = useNavigate()

  return (
    <div>
      {/* Hero — bleed past .main padding via negative margin in CSS */}
      <div className={styles.hero}>
        <div className={styles.heroBox}>
          <h2 className={styles.heroTitle}>GA4GH Implementation Registry</h2>
          <p className={styles.heroSubtitle}>
            A community registry of services, deployments, and tools that implement
            GA4GH Cloud API standards — including DRS, WES, TES, TRS, htsget,
            refget, Beacon, and Sequence Collections.
          </p>
        </div>
      </div>

      {/* Curation notice */}
      <div className={styles.curationBanner}>
        <span className={styles.bannerIcon}>ℹ️</span>
        <span>
          All data in the Implementation Registry will be manually curated
          before being made available in the Service Registry.
        </span>
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
