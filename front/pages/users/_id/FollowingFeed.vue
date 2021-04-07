<template>
  <v-card class="mx-auto" width="400px">
    <v-toolbar
      color="brown"
      dark
      flat
    >
      <v-toolbar-title>
        <v-icon>
          mdi-account-multiple-plus-outline
        </v-icon>
        <span>フォロー中のユーザ</span>
      </v-toolbar-title>
    </v-toolbar>
    <v-card-title v-if="!users.length">
      <p>フォロー中のユーザはいません</p>
    </v-card-title>
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
        color="brown lighten-2"
        class="mt-4 white--text more-loading"
        @click="moreLoading"
      >
        さらに読み込み
      </v-btn>
    </v-row>
  </v-card>
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
    this.$store.commit('setLoading', true)
    axios
      .get(`v1/users/${this.$route.params.id}/following`)
      .then((res) => {
        this.users = res.data
        this.$store.commit('setLoading', false)
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
