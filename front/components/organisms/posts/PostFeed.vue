<template>
  <div
  v-if="showPost">
  <v-card class="mx-auto mt-4 pa-3" width="400px" elevation="7">
  <v-row justify="center">全ユーザの投稿一覧</v-row>
  </v-card>
    <Post
      :user="posts[0].user"
      :post="posts[0]"
    />
    <Post
      v-for="post in posts"
      :key="post.id"
      :user="post.user"
      :post="post"
    />
    <v-row justify="center">
      <v-btn
        v-if="morePost"
        color="light-blue lighten-2"
        class="mt-4 white--text more-loading"
        @click="moreLoading"
      >
        記事読み込み
      </v-btn>
    </v-row>
  </div>
  <v-row justify="center" v-else>
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
      console.log('postfeed')
      this.$store.commit('setLoading', true)
      await this.$axios
        .$get('v1/posts')
        .then((res) => {
          console.log(res)
          this.posts = res
          this.postCount = this.posts.length
          this.showPost = true
          this.$store.commit('setLoading', false)
        })
    },
    async moreLoading () {
      const params = {
        offset: this.postCount
      }
      this.$store.commit('setLoading', true)
      await this.$axios
        .get('/v1/posts', { params })
        .then((res) => {
          console.log(res)
          console.log(res.data)
          const addPosts = res.data
          this.posts = this.posts.concat(addPosts)
          this.postCount = this.posts.length
          if (addPosts.length > 20) {
            this.morePost = true
          }
          this.$store.commit('setLoading', false)
        })
    }
  }
}
</script>

<style>
.more-loading {
  max-width: 400px;
}
</style>
