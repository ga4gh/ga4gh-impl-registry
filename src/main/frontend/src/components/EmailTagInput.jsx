import React, { useState } from 'react'
import styles from './EmailTagInput.module.css'

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export function EmailTagInput({ emails, onChange }) {
  const [input, setInput] = useState('')
  const [shake, setShake] = useState(false)

  function addEmail(raw) {
    const email = raw.trim().replace(/,$/, '')
    if (!email) return
    if (!EMAIL_RE.test(email)) {
      setShake(true)
      setTimeout(() => setShake(false), 600)
      return
    }
    if (emails.includes(email)) { setInput(''); return }
    onChange([...emails, email])
    setInput('')
  }

  function remove(i) {
    onChange(emails.filter((_, idx) => idx !== i))
  }

  function onKeyDown(e) {
    if (e.key === 'Enter' || e.key === ',') {
      e.preventDefault()
      addEmail(input)
    } else if (e.key === 'Backspace' && input === '' && emails.length) {
      remove(emails.length - 1)
    }
  }

  return (
    <div>
      <div
        className={styles.wrapper}
        onClick={() => document.getElementById('email-tag-input')?.focus()}
      >
        {emails.map((email, i) => (
          <span key={i} className={styles.tag}>
            {email}
            <button type="button" onClick={() => remove(i)} title="Remove">×</button>
          </span>
        ))}
        <input
          id="email-tag-input"
          className={`${styles.input} ${shake ? styles.shake : ''}`}
          type="text"
          value={input}
          placeholder={emails.length === 0 ? 'Type email and press Enter or comma' : ''}
          onChange={e => setInput(e.target.value)}
          onKeyDown={onKeyDown}
          onBlur={() => { if (input.trim()) addEmail(input) }}
        />
      </div>
      <p className={styles.hint}>Press Enter or comma to add each email address</p>
    </div>
  )
}
