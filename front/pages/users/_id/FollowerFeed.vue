<template>
  <div>
    <UsersInfo
      v-for="(user, $index) in users"
      :key="$index"
      :user="user"
      :followinglength="followinglength"
      :followerslength="followerslength"
    />
    <v-row justify="center">
      <v-btn
        v-if="moreUser"
        color="light-blue lighten-2"
        class="mt-4 white--text more-loading"
        @click="moreLoading"
      >
        さらに読み込み
      </v-btn>
    </v-row>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
import UsersInfo from '~/components/organisms/users/UsersInfo.vue'
export default {
  components: {
    UsersInfo
  },
  data () {
    return {
      userscount: 0,
      users: [],
      followinglength: Number,
      followerslength: Number,
      moreUser: false
    }
  },
  mounted () {
    axios
      .get(`v1/users/${this.$route.params.id}/followers`)
      .then((res) => {
        this.users = res.data
        console.log(this.users)
        console.log(this.users.length)
        this.followinglength = this.users.length
        console.log(this.followinglength)
      })
  },
  methods: {
    moreLoading () {
      const params = {
        offset: this.UserCount
      }
      axios
        .get(`/v1/users/${this.$route.params.id}/followers`, { params })
        .then((res) => {
          const addUsers = res.data
          this.users = this.users.concat(addUsers)
          this.UserCount = this.users.length
          if (addUsers.length < 20) {
            this.moreUser = false
          }
        })
    }
  }
}
</script>

<style>
</style>
