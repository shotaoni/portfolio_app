<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-card-title>
        <h2 class="user-edhit-title">
          プロフィール編集
        </h2>
      </v-card-title>
      <v-card-text>
        <v-form>
          <ChangeUsersAvatar
            rules="size:300"
            :value= "this.currentAvatarUrl"
          />
          <ChangeUsersName
            v-model="name"
            label="名前"
            rules="max:30|required"
          />
          <ChangeUsersProfile
            v-model="profile"
            label="プロフィール文"
            rules="max:140"
            :counter="140"
          />
        </v-form>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import ChangeUsersAvatar from '~/components/organisms/users/ChangeUsersAvatar.vue'
import ChangeUsersName from '~/components/organisms/users/ChangeUsersName.vue'
import ChangeUsersProfile from '~/components/organisms/users/ChangeUsersProfile.vue'
export default {
  components: {
    ChangeUsersAvatar,
    ChangeUsersName,
    ChangeUsersProfile
  },
  data () {
    return {
      name: '',
      profile: '',
      currentAvatarUrl: ''
    }
  },
  fetch ({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser) => {
        if (!newUser) {
          return redirect('/login')
        }
      }
    )
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    const setDefaultData = () => {
      axios
        .get(`/v1/users/${this.currentUser.id}`)
        .then((res) => {
          this.name = res.data.name
          this.profile = res.data.profile
          this.currentAvatarUrl = res.data.avatar_url
          console.log(res.data)
        })
    }
    if (this.currentUser.id) {
      setDefaultData()
    } else {
      setTimeout(setDefaultData, 1000)
    }
  }
}
</script>

<style>
</style>
