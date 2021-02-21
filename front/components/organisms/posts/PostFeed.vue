<template>
  <div>
    <Post
      v-for="(post, $index) in posts"
      :key="$index"
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
</template>

<script>
import axios from '@/plugins/axios'
import Post from '~/components/molecules/posts/Post.vue'
export default {
  components: {
    Post
  },
  data () {
    return {
      postCount: 0,
      posts: [],
      morePost: true
    }
  },
  mounted () {
    axios
      .get('v1/posts')
      .then((res) => {
        this.posts = res.data
        this.postCount = this.posts.length
      })
  },
  methods: {
    moreLoading () {
      const params = {
        offset: this.postCount
      }
      axios
        .get('/v1/posts', { params })
        .then((res) => {
          const addPosts = res.data
          this.posts = this.posts.concat(addPosts)
          this.postCount = this.posts.length
          if (addPosts.length < 20) {
            this.morePost = false
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
