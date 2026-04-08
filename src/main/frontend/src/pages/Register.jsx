import React, { useState, useContext } from 'react'
import { Link } from 'react-router-dom'
import { api } from '../api'
import { useApi } from '../hooks/useApi'
import { ImplForm } from '../components/ImplForm'
import { ToastContext } from '../App'
import styles from './Register.module.css'

const EMPTY_FORM = {
  implementationId: '', name: '', description: '', url: '',
  implementationType: 'SERVICE', environment: '', curiePrefix: '',
  contactEmails: [], documentationUrl: '', serviceInfoUrl: '',
  organisationId: '', standardId: '', standardVersionId: '',
  geolocation: { latitude: '', longitude: '', country: '', city: '' },
  implData: null
}

export function Register() {
  const { data: standards }    = useApi(api.getStandards)
  const { data: organisations } = useApi(api.getOrganisations)

  const showToast = useContext(ToastContext)
  const [formKey, setFormKey]     = useState(0)
  const [implError, setImplError] = useState(null)
  const [submitting, setSubmitting] = useState(false)

  async function handleImplSubmit(body) {
    setImplError(null)
    setSubmitting(true)
    try {
      if (body.implementationType === 'SERVICE') await api.createService(body)
      else await api.createDeployment(body)
      setFormKey(k => k + 1)
      showToast('Implementation registered successfully.')
    } catch (e) {
      setImplError(e.message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div>
      <h2>Register an Implementation</h2>

      <div className={styles.orgNote}>
        Need to add an organisation first?{' '}
        <Link to="/organisations">Go to the Organisations tab</Link> to register one,
        then come back here.
      </div>

      <div className={styles.card}>
        <ImplForm
          key={formKey}
          initial={EMPTY_FORM}
          standards={standards || []}
          organisations={organisations || []}
          onSubmit={handleImplSubmit}
          submitLabel={submitting ? 'Registering…' : 'Register Implementation'}
          error={implError}
        />
      </div>
    </div>
  )
}
