<template>
  <v-card>
    <v-card-title>
      <v-row justify="center">
      {{ user.name }}さんの投稿
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
    this.getmyposts()
  },
  methods: {
    async getmyposts () {
      await axios
        .get('v1/posts', {
          params: {
            my_post: this.$route.params.id
          }
        })
        .then((res) => {
          console.log(res)
          this.posts = res.data
        })
    }
  }
}
</script>

<style>
</style>
