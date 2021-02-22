import firebase from '@/plugins/firebase'
import axios from '@/plugins/axios'

export const setUser = (user, store) => {
  async function set (user, store) {
    if (user) {
      const { data } = await axios.get(`/v1/users?uid=${user.uid}`)
      const userParams = data
      console.log(data)
      store.commit('setUser', userParams)
      store.commit('setLoggedIn', true)
    } else {
      store.commit('setUser', null)
      store.commit('setLoggedIn', false)
    }
  }
  set(user, store)
}

const authCheck = ({ store, redirect }) => {
  firebase.auth().onAuthStateChanged(async (user) => {
    await setUser(user, store)
  })
}

export default authCheck
