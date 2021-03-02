<template>
  <v-container>
    <ErrorAnnounce :status="notFound" />
    <div v-if="!notFound" class="my-page-box">
      <v-row>
        <v-col lg="4" md="4" sm="4" cols="12">
          <UsersInfo :user="user" />
          <UsersLinks
          @openlikeposts="openLikePosts"
          />
        </v-col>
        <v-col lg="8" sm="8" cols="12">
          <UsersContents
          v-if="openlikeposts"
          :user="user"
          />
        </v-col>
      </v-row>
    </div>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import UsersInfo from '~/components/organisms/users/UsersInfo.vue'
import UsersLinks from '~/components/organisms/users/UsersLinks.vue'
import UsersContents from '~/components/organisms/users/UsersContents.vue'
import ErrorAnnounce from '~/components/molecules/ErrorAnnounce.vue'
export default {
  components: {
    ErrorAnnounce,
    UsersInfo,
    UsersLinks,
    UsersContents
  },
  data () {
    return {
      user: {},
      openlikeposts: false,
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
  },
  methods: {
    openLikePosts () {
      this.openlikeposts = true
    }
  }
}
</script>

<style>
</style>
