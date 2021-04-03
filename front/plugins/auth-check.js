import firebase from '@/plugins/firebase'

const authCheck = ({ store }) => {
  firebase.auth().onAuthStateChanged((user) => {
    setUser(user, store)
  })
}

export const setUser = (user, store) => {
  async function set (user, store) {
    if (user) {
      const { data } = await this.$axios.get(`/v1/users?uid=${user.uid}`)
      const userParams = data
      store.commit('setUser', userParams)
      store.commit('setLoggedIn', true)
      store.commit('setLoading', false)
    } else {
      store.commit('setUser', null)
      store.commit('setLoggedIn', false)
      store.commit('setLoading', false)
    }
  }
  set(user, store)
}

export default authCheck
