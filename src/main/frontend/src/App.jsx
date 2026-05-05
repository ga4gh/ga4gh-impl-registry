import React from 'react'
import { NavLink, Routes, Route, Navigate } from 'react-router-dom'
import { Home }            from './pages/Home'
import { ServiceInfo }     from './pages/ServiceInfo'
import { Standards }       from './pages/Standards'
import { Implementations } from './pages/Implementations'
import { Organisations }   from './pages/Organisations'
import { Register }        from './pages/Register'
import { Toast }           from './components/Toast'
import { useToast }        from './hooks/useToast'
import styles from './App.module.css'

export const ToastContext = React.createContext(null)

export default function App() {
  const { message, visible, showToast } = useToast()

  return (
    <ToastContext.Provider value={showToast}>

      {/* ── Header ── */}
      <header className={styles.header}>
        <div className={styles.headerLeft}>
          <img
            src="/assets/logo-full-color.svg"
            alt="GA4GH logo"
            className={styles.logo}
          />
          <div className={styles.headerDivider} />
          <div className={styles.headerTitle}>
            <h1>Implementation Registry</h1>
            <span>Registry of GA4GH Cloud API Implementations</span>
          </div>
        </div>
      </header>

      {/* ── Tab nav ── */}
      <nav className={styles.nav}>
        <NavLink to="/"              end className={({ isActive }) => isActive ? styles.active : ''}>Home</NavLink>
        <NavLink to="/service-info"  className={({ isActive }) => isActive ? styles.active : ''}>Service Info</NavLink>
        <NavLink to="/standards"     className={({ isActive }) => isActive ? styles.active : ''}>Standards</NavLink>
        <NavLink to="/services"      className={({ isActive }) => isActive ? styles.active : ''}>Services</NavLink>
        <NavLink to="/deployments"   className={({ isActive }) => isActive ? styles.active : ''}>Deployments</NavLink>
        <NavLink to="/organisations" className={({ isActive }) => isActive ? styles.active : ''}>Organisations</NavLink>
        <NavLink to="/register"      className={({ isActive }) => isActive ? styles.active : ''}>+ Register</NavLink>
      </nav>

      {/* ── Page content ── */}
      <main className={styles.main}>
        <Routes>
          <Route path="/"              element={<Home />} />
          <Route path="/service-info"  element={<ServiceInfo />} />
          <Route path="/standards"     element={<Standards />} />
          <Route path="/services"      element={<Implementations type="SERVICE" />} />
          <Route path="/deployments"   element={<Implementations type="DEPLOYMENT" />} />
          <Route path="/organisations" element={<Organisations />} />
          <Route path="/register"      element={<Register />} />
          <Route path="*"              element={<Navigate to="/" replace />} />
        </Routes>
      </main>

      {/* ── Footer ── */}
      <footer className={styles.footer}>
        <span>© {new Date().getFullYear()} Global Alliance for Genomics and Health · </span>
        <a href="https://www.ga4gh.org" target="_blank" rel="noopener">ga4gh.org</a>
      </footer>

      <Toast message={message} visible={visible} />
    </ToastContext.Provider>
  )
}
