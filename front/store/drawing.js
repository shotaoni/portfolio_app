export const state = () => ({
  loading: false,
  flash: {
    status: false,
    type: '',
    message: ''
  }
})

export const mutations = {
  setLoading (state, payload) {
    state.loading = payload
  },
  setFlash (state, payload) {
    state.flash = payload
  }
}
