import axios from 'axios'

export default axios.create({
  baseURL: process.env.NODE_ENV === 'production' ? 'https://hellotante.com:3000' : 'http://localhost:3000'
})
