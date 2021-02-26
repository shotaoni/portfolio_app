import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export const state = () => ({
  currentUser: {
    id: '',
    id_token: '',
    name: '',
    email: '',
    profile: '',
    avatar_url: '',
    following: []
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
  setUserAvatarUrl (state, payload) {
    state.currentUser.avatar_url = payload
  },
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  },
  setLoading (state, payload) {
    state.loading = payload
  },
  setFlash (state, payload) {
    state.flash = payload
  },
  setFollowing (state, payload) {
    state.currentUser.following = payload.map((p) => {
      return p.id
    })
  },
  addFollowing (state, payload) {
    state.currentUser.following.unshift(payload)
  },
  removeFollowing (state, payload) {
    state.currentUser.following = state.currentUser.following.filter((l) => {
      return l !== payload
    })
  }
}

export const actions = {
}
