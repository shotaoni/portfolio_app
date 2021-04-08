<template>
  <div
    v-if="showPost"
  >
    <v-card class="mx-auto" width="400px" elevation="7">
      <v-toolbar
        color="brown"
        dark
        flat
      >
        <v-toolbar-title>
          <v-icon>
            mdi-heart-multiple-outline
          </v-icon>
          <span>人気の投稿</span>
        </v-toolbar-title>
      </v-toolbar>
    </v-card>
    <Post
      v-for="post in posts"
      :key="post.id"
      :user="post.user"
      :post="post"
    />
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
  <v-row v-else justify="center">
    投稿はまだありません
  </v-row>
</template>

<script>
import Post from '~/components/molecules/posts/Post.vue'
export default {
  components: {
    Post
  },
  data () {
    return {
      postCount: 0,
      posts: [],
      morePost: true,
      showPost: false
    }
  },
  mounted () {
    this.postsGet()
  },
  methods: {
    async postsGet () {
      this.$store.commit('setLoading', true)
      await this.$axios
        .$get('v1/posts/ranking')
        .then((res) => {
          console.log(res)
          this.posts = res
          this.postCount = this.posts.length
          this.showPost = true
          if (res.length < 20) {
            this.morePost = false
          } else {
            this.morePost = true
          }
          this.$store.commit('setLoading', false)
        })
    },
    async moreLoading () {
      const params = {
        offset: this.postCount
      }
      this.$store.commit('setLoading', true)
      await this.$axios
        .get('/v1/posts/ranking', { params })
        .then((res) => {
          const addPosts = res.data
          this.posts = this.posts.concat(addPosts)
          this.postCount = this.posts.length
          if (addPosts.length > 20) {
            this.morePost = true
          } else {
            this.morePost = false
          }
          this.$store.commit('setLoading', false)
        })
    }
  }
}
</script>

<style>
</style>
