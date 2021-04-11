import axios from 'axios'

export default axios.create({
  baseURL: process.env.NODE_ENV === 'production' ? process.env.API_ENDPOINT : 'http://localhost:3000'
})
