<template>
  <div
  v-if="showPost">
    <Post
      :user="posts[0].user"
      :post="posts[0]"
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
      morePost: false,
      showPost: false
    }
  },
  mounted () {
    this.postsGet()
  },
  methods: {
    async postsGet () {
      console.log('postfeed')
      await this.$axios
        .$get('v1/posts')
        .then((res) => {
          console.log(res)
          this.posts = res
          this.postCount = this.posts.length
          this.showPost = true
        })
    },
    async moreLoading () {
      const params = {
        offset: this.postCount
      }
      await this.$axios
        .get('/v1/posts', { params })
        .then((res) => {
          const addPosts = res.data
          this.posts = this.posts.concat(addPosts)
          this.postCount = this.posts.length
          if (addPosts.length > 20) {
            this.morePost = true
          }
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
