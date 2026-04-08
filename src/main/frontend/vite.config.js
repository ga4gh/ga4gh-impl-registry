import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  // In dev mode, proxy all /api requests to Spring Boot running on 8080
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  },
  // Build output goes directly into Spring Boot's static resources folder
  build: {
    outDir: '../resources/static',
    emptyOutDir: true
  }
})
