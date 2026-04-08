import { useState, useEffect, useCallback } from 'react'

/**
 * Generic fetch hook.
 * fetchFn   — async function that returns data
 * deps      — re-fetch when these change (default: fetch once on mount)
 *
 * Returns { data, loading, error, refresh }
 * refresh() manually re-fetches without changing deps
 */
export function useApi(fetchFn, deps = []) {
  const [data, setData]       = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError]     = useState(null)
  const [tick, setTick]       = useState(0)

  const refresh = useCallback(() => setTick(t => t + 1), [])

  useEffect(() => {
    let cancelled = false
    setLoading(true)
    setError(null)
    fetchFn()
      .then(d  => { if (!cancelled) { setData(d); setLoading(false) } })
      .catch(e => { if (!cancelled) { setError(e.message); setLoading(false) } })
    return () => { cancelled = true }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [...deps, tick])

  return { data, loading, error, refresh }
}
