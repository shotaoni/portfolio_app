<template>
  <v-container>
    <ErrorAnnounce
    :status="notFound"
    />
    <PostEditDialog
    :dialog="dialog"
    @closeDialog="dialog = false"
    />
    <div class="posts-show-box" v-if="!notFound">
      <v-card class="mx-auto mt-4 pa-3" width="400px">
        <v-card-title>
          <h2 class="post-show-title">{{post.title}}</h2>
          </v-card-title>
        <div class="post-show-header px-2">
          <UsersLink
          :user="user"
          />
          <div
          class="post-show-change-box"
          v-if="currentUser && currentUser.id === user.id"
          >
          <v-btn
          @click="dialog = !dialog"
          outlined
          fab
          small
          color="light-blue lighten-3"
          >
          <v-icon>mdi-pencil</v-icon>
          </v-btn>
          <v-btn
          @click="destroyPost"
          outlined
          fab
          small
          color="red lighten-3"
          >
          <v-icon>mdi-delete-forever</v-icon>
          </v-btn>
          </div>
        </div>
         <div class="posts-point" style="white-space: pre-line">{{ point }}</div>
      <LinkCard
      v-for="link in links"
      :key="link.id"
      :link="link"
      />
      </v-card>
    </div>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import PostEditDialog from '~/components/organisms/PostEditDialog.vue'
import LinkCard from '~/components/molecules/LinkCard.vue'
import UsersLink from '~/components/molecules/UsersLink.vue'
import ErrorAnnounce from '~/components/molecules/ErrorAnnounce.vue'
export default {
  components: {
    ErrorAnnounce,
    UsersLink,
    LinkCard,
    PostEditDialog
  },
  data () {
    return {
      user: {},
      post: {},
      point: '',
      links: '',
      notFound: false,
      dialog: false
    }
  },
  mounted () {
    axios
      .get(`/v1/posts/${this.$route.params.id}`)
      .then((res) => {
        this.user = res.data.user
        this.post = res.data
        this.point = res.data.point
        this.links = res.data.links
      })
      .catch((error) => {
        if (error.response.status === 404) {
          this.notFound = true
        }
      })
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  methods: {
    openDialog () {
      this.dialog = true
    },
    destroyPost () {
      this.$store.commit('setLoading', true)
      axios
        .delete(`/v1/posts/${this.$route.params.id}`, { id: this.user.id })
        .then((res) => {
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: '投稿を削除しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
          this.$router.push('/')
        })
    }
  }
}
</script>

<style>
.posts-point {
  margin-top: 24px
}

.post-show-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
