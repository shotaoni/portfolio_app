<template>
  <v-container v-if="commentview" class="comment-container">
    <v-card class="comment-card mx-auto" width="600px">
      <v-card-title>
        <UsersLink
          :user="user"
          :post="post"
        />
        <v-spacer />
        <div
          v-if="user.id === currentUser.id"
          class="comment-show-change-box"
        >
          <v-btn
            outlined
            fab
            x-small
            color="red lighten-3"
            @click="deletecomment"
          >
            <v-icon>mdi-delete-forever</v-icon>
          </v-btn>
        </div>
        <v-spacer />
      </v-card-title>
      <v-card-text>
        <v-row>
          {{ comment.content }}
        </v-row>
        <v-row>
          <v-spacer />
        </v-row>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import UsersLink from '~/components/molecules/UsersLink.vue'
export default {
  components: {
    UsersLink
  },
  props: {
    post: {
      type: Object,
      default: null
    },
    comment: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      user: {},
      commentview: true
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.getcomments()
  },
  methods: {
    deletecomment () {
      axios
        .delete(`v1/comments/${this.comment.id}`)
        .then(() => {
          this.commentview = false
          this.$emit('getcount')
          this.$store.commit('setFlash', {
            status: true,
            message: 'コメントを削除しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1000)
        })
    },
    getcomments () {
      axios
        .get(`v1/users/${this.comment.user_id}`)
        .then((res) => {
          this.user = res.data
        })
    }
  }
}
</script>

<style>
</style>
