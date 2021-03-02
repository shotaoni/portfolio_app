<template>
  <v-card class="mx-auto mt-4 pa-3" width="400px">
    <v-card-title class="py-2">
      <nuxt-link :to="`/posts/${post.id}`" style="color:#263238; text-decoration:none;">
        <p>{{ post.title }}</p>
      </nuxt-link>
    </v-card-title>
    <v-card-text>
      <UsersLink
        :user="user"
        :post="post"
      />
      <div class="post-index-point mt-2">
        {{ post.point }}
      </div>
      <v-col cols="12" v-if="post.links">
        <LinkCard
          v-for="link in links"
          :key="link.id"
          :link="link"
        />
        <LikeButton
        :alreadylike="alreadylike"
        :user="user"
        :post="post"
        @likepostnone="likepostnone"
        @likepost="likepost"
        />
        {{ this.likeCount }}
      </v-col>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios.js'
import LinkCard from '~/components/molecules/LinkCard.vue'
import UsersLink from '~/components/molecules/UsersLink.vue'
import LikeButton from '~/components/atoms/LikeButton.vue'
export default {
  components: {
    UsersLink,
    LinkCard,
    LikeButton
  },
  data () {
    return {
      links: '',
      alreadylike: Boolean,
      likeCount: Number
    }
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.likepostcount()
    axios
      .get(`/v1/posts/${this.post.id}`)
      .then((res) => {
        this.links = res.data.links
      })
      .catch((error) => {
        if (error.response.status === 404) {
          this.notFound = true
        }
      })
  },
  methods: {
    likepost () {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/likes', {
          userid: this.currentUser.id,
          post_id: this.post.id
        })
        .then(() => {
          this.alreadylike = true
          this.likeCount++
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'いいねしました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1000)
        })
    },
    likepostnone () {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/likes/likenone', {
          user_id: this.currentUser.id,
          post_id: this.post.id
        })
        .then(() => {
          this.alreadylike = false
          this.likeCount--
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'いいねを取り消しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1000)
        })
    },
    likepostcount () {
      axios
        .get('v1/likes', {
          params: {
            post_id: this.post.id
          }
        })
        .then((res) => {
          const postLikes = res.data
          this.likeCount = postLikes.length
          console.log(postLikes)
          console.log(res.data)
        })
    }
  }
}
</script>

<style>
.post-index-point {
  white-space: pre-line
}
</style>
