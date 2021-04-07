<template>
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
      posts: []
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
            following_post: this.$route.params.id
          }
        })
        .then((res) => {
          this.posts = res.data
          this.$store.commit('setLoading', false)
        })
    }
  }
}
</script>

<style>
</style>
