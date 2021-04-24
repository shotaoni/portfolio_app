<template>
  <div>
    <v-card>
      <v-toolbar
        color="brown"
        dark
        flat
      >
        <v-toolbar-title>
          <v-icon>
            mdi-clock-time-three-outline
          </v-icon>
          フォローしているユーザのタイムライン
        </v-toolbar-title>
      </v-toolbar>
      <v-card-text>
        <Post
          v-for="(post, $index) in posts"
          :key="$index"
          :user="post.user"
          :post="post"
        />
      </v-card-text>
    </v-card>
    <v-row justify="center">
      <v-btn
        v-if="morePost"
        color="brown lighten-2"
        class="mt-4 white--text more-loading"
        @click="moreLoading"
      >
        記事読み込み
      </v-btn>
    </v-row>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
import Post from '~/components/molecules/posts/Post.vue'
export default {
  components: {
    Post
  },
  props: {
    user: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      posts: [],
      postCount: 0,
      morePost: false,
      count: 1
    }
  },
  mounted () {
    this.getfollowingposts()
  },
  methods: {
    async getfollowingposts () {
      this.$store.commit('setLoading', true)
      await axios
        .get('v1/posts', {
          params: {
            following_post: this.$route.params.id,
            page: this.count
          }
        })
        .then((res) => {
          this.count++
          this.posts = res.data
          this.postCount = res.data.length
          if (res.data.length < 20) {
            this.morePost = false
          } else {
            this.morePost = true
          }
          this.$store.commit('setLoading', false)
        })
    },
    async moreLoading () {
      const params = {
        page: this.count,
        following_post: this.$route.params.id
      }
      this.$store.commit('setLoading', true)
      await this.$axios
        .get('/v1/posts', { params })
        .then((res) => {
          this.count++
          const addPosts = res.data
          this.posts = this.posts.concat(addPosts)
          this.postCount = this.posts.length
          if (addPosts.length < 20) {
            this.morePost = false
          } else {
            this.morePost = true
          }
          this.$store.commit('setLoading', false)
        })
    }
  }
}
</script>

<style>
</style>
