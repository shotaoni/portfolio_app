<template>
  <div>
    <v-card class="mx-auto mt-4 pa-3" width="400px">
      <v-card>
        <v-card-title>
          <v-card-text v-if="users.length">
            <p>フォロー中のユーザ</p>
          </v-card-text>
          <v-card-text v-else>
            <p>フォロー中のユーザはいません</p>
          </v-card-text>
        </v-card-title>
      </v-card>
      <v-card-text>
        <UsersLink
          v-for="(user, $index) in users"
          :key="$index"
          :user="user"
        />
      </v-card-text>

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
    </v-card>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
import UsersLink from '~/components/molecules/UsersLink.vue'
export default {
  components: {
    UsersLink
  },
  data () {
    return {
      userscount: 0,
      users: [],
      moreUser: false
    }
  },
  mounted () {
    axios
      .get(`v1/users/${this.$route.params.id}/following`)
      .then((res) => {
        this.users = res.data
      })
  },
  methods: {
    moreLoading () {
      const params = {
        offset: this.UserCount
      }
      axios
        .get(`/v1/users/${this.$route.params.id}/following`, { params })
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
