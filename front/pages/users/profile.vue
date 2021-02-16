<template>
  <v-container>
    <v-card class="mx-auto mt-5 pa-5" width="400px">
      <v-card-title>
        <h2 class="user-edhit-title">プロフィール編集</h2>
      </v-card-title>
      <v-card-text>
        <v-form>
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
import ChangeUsersName from '~/components/organisms/users/ChangeUsersName.vue'
import ChangeUsersProfile from '~/components/organisms/users/ChangeUsersProfile.vue'
export default {
  components: {
    ChangeUsersName,
    ChangeUsersProfile
  },
  data () {
    return {
      name: '',
      profile: ''
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    const setDefaultData = () => {
      axios
        .get(`/v1/users/${this.currentUser.id}/edit`)
        .then((res) => {
          this.name = res.data.name
          this.profile = res.data.profile
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
