<template>
  <v-card>
    <v-card-title justify="center">
      <p>タイムライン</p>
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
export default {
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
    this.getfollowingposts()
  },
  methods: {
    async getfollowingposts () {
      await console.log(this.user.id)
      await axios
        .get('v1/posts', {
          params: {
            following_post: this.$route.params.id
          }
        })
        .then((res) => {
          this.posts = res.data
          console.log(res)
          console.log(res.data)
          console.log(res.data.post)
          console.log(this.posts)
        })
    }
  }
}
</script>

<style>
</style>
