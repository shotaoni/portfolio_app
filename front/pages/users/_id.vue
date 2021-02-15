<template>
  <v-container>
    <ErrorAnnounce :status="notFound" />
<div class='hoge' v-if="!notFound">
  <p>ユーザー名:{{ user.name }}</p>
  <p>メールアドレス:{{ user.email }}</p>
</div>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import ErrorAnnounce from '~/components/molecules/ErrorAnnounce.vue'
export default {
  components: {
    ErrorAnnounce
  },
  data () {
    return {
      user: {},
      notFound: false
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    axios
      .get(`/v1/users/${this.$route.params.id}`)
      .then((res) => {
        const user = res.data
        this.user = user
      })
      .catch((error) => {
        if (error.response.status === 404) {
          this.notFound = true
        }
      })
  }
}
</script>

<style>
</style>
