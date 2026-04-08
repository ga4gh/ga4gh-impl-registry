import React from 'react'
import { NavLink, Routes, Route, Navigate } from 'react-router-dom'
import { ServiceInfo }   from './pages/ServiceInfo'
import { Standards }     from './pages/Standards'
import { Implementations } from './pages/Implementations'
import { Organisations } from './pages/Organisations'
import { Register }      from './pages/Register'
import { Toast }         from './components/Toast'
import { useToast }      from './hooks/useToast'
import styles from './App.module.css'

export const ToastContext = React.createContext(null)

export default function App() {
  const { message, visible, showToast } = useToast()

  return (
    <ToastContext.Provider value={showToast}>
      <header className={styles.header}>
        <div>
          <h1>GA4GH Registry</h1>
          <span>Registry of GA4GH Cloud API Implementations</span>
        </div>
      </header>

      <nav className={styles.nav}>
        <NavLink to="/service-info"  className={({ isActive }) => isActive ? styles.active : ''}>Service Info</NavLink>
        <NavLink to="/standards"     className={({ isActive }) => isActive ? styles.active : ''}>Standards</NavLink>
        <NavLink to="/services"      className={({ isActive }) => isActive ? styles.active : ''}>Services</NavLink>
        <NavLink to="/deployments"   className={({ isActive }) => isActive ? styles.active : ''}>Deployments</NavLink>
        <NavLink to="/organisations" className={({ isActive }) => isActive ? styles.active : ''}>Organisations</NavLink>
        <NavLink to="/register"      className={({ isActive }) => isActive ? styles.active : ''}>+ Register</NavLink>
      </nav>

      <main className={styles.main}>
        <Routes>
          <Route path="/"              element={<Navigate to="/service-info" replace />} />
          <Route path="/service-info"  element={<ServiceInfo />} />
          <Route path="/standards"     element={<Standards />} />
          <Route path="/services"      element={<Implementations type="SERVICE" />} />
          <Route path="/deployments"   element={<Implementations type="DEPLOYMENT" />} />
          <Route path="/organisations" element={<Organisations />} />
          <Route path="/register"      element={<Register />} />
        </Routes>
      </main>

      <Toast message={message} visible={visible} />
    </ToastContext.Provider>
  )
}
