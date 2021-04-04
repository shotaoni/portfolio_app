<template>
  <v-card flat>
    <v-card-title>
      コメントを探す
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="commentword"
        hint="探したいコメントの単語を入力してください"
      >
        <v-icon slot="prepend">
          mdi-magnify
        </v-icon>
      </v-text-field>
    </v-card-text>
    <Comment
      v-for="comment in comments"
      :key="comment.id"
      :comment="comment"
    />
  </v-card>
</template>

<script>
import _ from 'lodash'
import axios from '@/plugins/axios'
import Comment from '~/components/molecules/Comment.vue'
export default {
  components: {
    Comment
  },
  data () {
    return {
      comments: [],
      commentword: ''
    }
  },
  watch: {
    commentword () {
      if (this.commentword) {
        this.delayFunc()
      } else {
        this.comments = []
      }
    }
  },
  created () {
    this.delayFunc = _.debounce(this.search, 50)
  },
  methods: {
    search () {
      console.log(this.commentword)
      axios
        .get('v1/comments', {
          params: {
            title: this.commentword
          }
        })
        .then((res) => {
          this.comments = res.data
        })
    }
  }
}
</script>

<style>
</style>
