<template>
  <v-card class="mx-auto mt-4 pa-3" width="400px" elevation="7">
    <v-card-title class="py-2">
      <nuxt-link :to="`/posts/${post.id}`" style="color:#263238; text-decoration:none;">
        <p>{{ post.title }}</p>
      </nuxt-link>
    </v-card-title>
    <v-card-text>
      <UsersLink
        :user="user"
        :post="post"
      />
      <div class="post-index-point mt-2">
        {{ post.point }}
      </div>
      <v-col cols="12" v-if="post.links">
        <LinkCard
          v-for="link in links"
          :key="link.id"
          :link="link"
        />
      </v-col>
      <v-row>
        <LikeButton
        :alreadylike="alreadylike"
        :user="user"
        :post="post"
        @likepostnone="likepostnone"
        @likepost="likepost"
        />
        {{ this.likeCount }}
        <v-spacer />
        <Button
        large
        color="blue darken-2"
        type="mdi-message-text"
        @tap="openComments = !openComments"
        />
        <Button
        large
        color="blue darken-2"
        type="mdi-comment-eye-outline"
        @click="openCommentslog = !openCommentslog"
        />
        {{ comments.length }}
      </v-row>
      <ValidationObserver ref="obs" v-slot="ObserverProps" v-if="openComments">
      <TextArea
      rules="max:200|required"
      :counter="200"
      label="コメント"
      v-model="content"
      />
      <v-row>
        <v-spacer />
        <v-btn
        color="blue darken-1"
        text
        @click="createComment"
        style="margin-top: 10px;"
        :disabled="ObserverProps.invalid || !ObserverProps.validated"
        >コメントする</v-btn>
      </v-row>
      </ValidationObserver>
      <div v-if="openCommentslog">
      <Comment
      @getcount="getcreatepost"
      v-for="comment in comments"
      :key="comment.id"
      :user="user"
      :post="post"
      :comment="comment"
      />
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios.js'
import Button from '~/components/atoms/Button.vue'
import LinkCard from '~/components/molecules/LinkCard.vue'
import UsersLink from '~/components/molecules/UsersLink.vue'
import LikeButton from '~/components/atoms/LikeButton.vue'
export default {
  components: {
    UsersLink,
    LinkCard,
    LikeButton,
    Button
  },
  data () {
    return {
      links: '',
      content: '',
      comments: [],
      alreadylike: Boolean,
      likeCount: Number,
      openComments: false,
      openCommentslog: false
    }
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.likepostcount()
    this.getcreatepost()
    axios
      .get(`/v1/posts/${this.post.id}`)
      .then((res) => {
        this.links = res.data.links
      })
      .catch((error) => {
        if (error.response.status === 404) {
          this.notFound = true
        }
      })
  },
  methods: {
    likepost () {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/likes', {
          userid: this.currentUser.id,
          post_id: this.post.id
        })
        .then(() => {
          this.alreadylike = true
          this.likeCount++
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'いいねしました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1000)
        })
    },
    likepostnone () {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/likes/likenone', {
          user_id: this.currentUser.id,
          post_id: this.post.id
        })
        .then(() => {
          this.alreadylike = false
          this.likeCount--
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'いいねを取り消しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1000)
        })
    },
    likepostcount () {
      axios
        .get('v1/likes', {
          params: {
            post_id: this.post.id
          }
        })
        .then((res) => {
          const postLikes = res.data
          this.likeCount = postLikes.length
          console.log(postLikes)
          console.log(res.data)
        })
    },
    getcreatepost () {
      axios
        .get(`v1/posts/${this.post.id}/comments`)
        .then((res) => {
          console.log(res.data)
          console.log(res)
          this.comments = res.data
        })
    },
    createComment () {
      this.openComments = false
      axios
        .post('v1/comments', {
          content: this.content,
          post_id: this.post.id,
          user_id: this.currentUser.id
        })
        .then((res) => {
          console.log(res.data)
          this.getcreatepost()
          this.$store.commit('setFlash', {
            status: true,
            message: 'コメントを投稿しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1000)
        })
      this.content = ''
    }
  }
}
</script>

<style>
.post-index-point {
  white-space: pre-line
}
</style>
