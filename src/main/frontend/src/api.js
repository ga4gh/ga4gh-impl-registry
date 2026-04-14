const BASE = '/api'

async function request(path, options = {}) {
  const res = await fetch(BASE + path, {
    headers: { 'Content-Type': 'application/json' },
    ...options
  })
  const data = await res.json()
  if (!res.ok) throw new Error(data.message || `HTTP ${res.status}`)
  return data
}

export const api = {
  getServiceInfo:     () => request('/service-info'),
  getStandards:       () => request('/standards'),
  getServices:        () => request('/services'),
  getDeployments:     () => request('/deployments'),
  getOrganisations:   () => request('/organisations'),

  createService:      (body) => request('/services',      { method: 'POST', body: JSON.stringify(body) }),
  createDeployment:   (body) => request('/deployments',   { method: 'POST', body: JSON.stringify(body) }),
  createOrganisation: (body) => request('/organisations', { method: 'POST', body: JSON.stringify(body) }),

  updateService:      (id, body) => request(`/services/${id}`,      { method: 'PUT', body: JSON.stringify(body) }),
  updateDeployment:   (id, body) => request(`/deployments/${id}`,   { method: 'PUT', body: JSON.stringify(body) }),
  updateOrganisation: (id, body) => request(`/organisations/${id}`, { method: 'PUT', body: JSON.stringify(body) }),
}
