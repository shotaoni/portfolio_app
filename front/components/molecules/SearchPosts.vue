<template>
  <v-card flat>
    <v-card-title>
      投稿を探す
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="postword"
        hint="探したい単語を入力してください"
      >
        <v-icon slot="prepend">
          mdi-magnify
        </v-icon>
      </v-text-field>
    </v-card-text>
    <Post
      v-for="(post, $index) in posts"
      :key="$index"
      :user="post.user"
      :post="post"
    />
  </v-card>
</template>

<script>
import _ from 'lodash'
import axios from '@/plugins/axios'
import Post from '~/components/molecules/posts/Post.vue'
export default {
  components: {
    Post
  },
  data () {
    return {
      posts: [],
      postword: ''
    }
  },
  watch: {
    postword () {
      this.delayFunc()
    }
  },
  created () {
    this.delayFunc = _.debounce(this.search, 500)
  },
  methods: {
    search () {
      axios
        .get('v1/posts', {
          params: {
            title: this.postword
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
