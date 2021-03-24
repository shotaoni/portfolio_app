import firebase from '@/plugins/firebase'
import axios from '@/plugins/axios'

const authCheck = ({ store }) => {
  firebase.auth().onAuthStateChanged((user) => {
    setUser(user, store)
  })
}

export const setUser = (user, store) => {
  async function set (user, store) {
    if (user.id) {
      const { data } = await axios.get(`/v1/users?uid=${user.uid}`)
      const userParams = data
      console.log('ログインしているユーザー:', data)
      console.log(data)
      console.log(userParams)
      console.log(data.uid)
      store.commit('setUser', userParams)
      store.commit('setLoggedIn', true)
    } else {
      store.commit('setUser', null)
      store.commit('setLoggedIn', false)
    }
  }
  set(user, store)
}

export default authCheck
