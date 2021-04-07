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
            mdi-table-heart
          </v-icon>
          {{ user.name }}さんがいいねした投稿
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
      morePost: false
    }
  },
  mounted () {
    this.getlikeposts()
  },
  methods: {
    async getlikeposts () {
      this.$store.commit('setLoading', true)
      await axios
        .get('v1/posts', {
          params: {
            user_like_posts: this.$route.params.id
          }
        })
        .then((res) => {
          this.posts = res.data
          this.postCount = res.data.length
          console.log(this.postCount)
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
        offset: this.postCount,
        user_like_posts: this.$route.params.id
      }
      this.$store.commit('setLoading', true)
      await this.$axios
        .get('/v1/posts', { params })
        .then((res) => {
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
