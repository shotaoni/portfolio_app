import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export const state = () => ({
  currentUser: {
    id: '',
    name: '',
    email: '',
    profile: ''
  },
  loggedIn: false,
  loading: false,
  flash: {
    status: false,
    message: ''
  }
})

export const mutations = {
  setUser (state, payload) {
    state.currentUser = payload
  },
  setUserName (state, payload) {
    state.currentUser.name = payload
  },
  setUserProfile (state, payload) {
    state.currentUser.profile = payload
  },
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  },
  setLoading (state, payload) {
    state.loading = payload
  },
  setFlash (state, payload) {
    state.flash = payload
  }
}

export const actions = {
}
