import axios from 'axios'

export default axios.create({
  baseURL: process.env.NODE_ENV === 'production' ? 'https://hellotante-api.com' : 'http://localhost:3000'
})
