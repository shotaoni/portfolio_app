<template>
  <v-container>
    <ErrorAnnounce :status="notFound" />
    <div v-if="!notFound" class="my-page-box">
      <v-row>
        <v-col lg="4" md="4" sm="4" cols="12">
          <UsersInfo :user="user" />
          <UsersLinks
            :user="user"
            @openlikeposts="openLikePosts"
            @opentimeline="openTimeLine"
            @openusertimeline="openUserTimeLine"
          />
        </v-col>
        <v-col lg="8" sm="8" cols="12">
          <UsersLikeContents
            v-if="openlikeposts"
            :user="user"
          />
          <UsersFollowTimeline
            v-if="!openlikeposts && openfollowtimeline && currentUser.id === user.id"
            :user="user"
          />
          <OwnUsersTimeline
            v-if="openusertimeline && !openlikeposts && !openfollowtimeline"
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
import UsersLikeContents from '~/components/organisms/users/UsersLikeContents.vue'
import UsersFollowTimeline from '~/components/organisms/users/UsersFollowTimeLine.vue'
import OwnUsersTimeline from '~/components/organisms/users/OwnUsersTimeline.vue'
import ErrorAnnounce from '~/components/molecules/ErrorAnnounce.vue'
export default {
  components: {
    ErrorAnnounce,
    UsersInfo,
    UsersLinks,
    UsersLikeContents,
    UsersFollowTimeline,
    OwnUsersTimeline
  },
  data () {
    return {
      user: {},
      openlikeposts: false,
      notFound: false,
      openusertimeline: true,
      openfollowtimeline: false
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.$store.commit('setLoading', true)
    axios
      .get(`/v1/users/${this.$route.params.id}`)
      .then((res) => {
        const user = res.data
        this.user = user
        this.$store.commit('setLoading', false)
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
      this.openusertimeline = false
      this.openfollowtimeline = false
    },
    openTimeLine () {
      this.openlikeposts = false
      this.openusertimeline = false
      this.openfollowtimeline = true
    },
    openUserTimeLine () {
      this.openusertimeline = true
      this.openlikeposts = false
      this.openfollowtimeline = false
    }
  }
}
</script>

<style>
</style>
