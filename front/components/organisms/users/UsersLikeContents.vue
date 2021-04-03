<template>
  <v-card>
    <v-card-title>
      <v-row justify="center">
        <p>いいね！したやつ</p>
      </v-row>
    </v-card-title>
    <v-card-text>
      <Post
        v-for="(post, $index) in posts"
        :key="$index"
        :user="post.user"
        :post="post"
      />
    </v-card-text>
  </v-card>
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
      type: Object
    }
  },
  data () {
    return {
      posts: []
    }
  },
  mounted () {
    this.getlikeposts()
  },
  methods: {
    async getlikeposts () {
      await axios
        .get('v1/posts', {
          params: {
            user_like_posts: this.$route.params.id
          }
        })
        .then((res) => {
          this.posts = res.data
        })
    }
  }
}
</script>

<style>
</style>
