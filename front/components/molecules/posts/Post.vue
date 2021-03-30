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
      <v-col v-if="post.links" cols="12">
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
        {{ likeCount }}
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
      <ValidationObserver v-if="openComments" ref="obs" v-slot="ObserverProps">
        <TextArea
          v-model="content"
          rules="max:200|required"
          :counter="200"
          label="コメント"
        />
        <v-row>
          <v-spacer />
          <v-btn
            color="blue darken-1"
            text
            style="margin-top: 10px;"
            :disabled="ObserverProps.invalid || !ObserverProps.validated"
            @click="createComment"
          >
            コメントする
          </v-btn>
        </v-row>
      </ValidationObserver>
      <div v-if="openCommentslog">
        <Comment
          v-for="comment in comments"
          :key="comment.id"
          :user="user"
          :post="post"
          :comment="comment"
          @getcount="getcreatepost"
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
import Comment from '~/components/molecules/Comment.vue'
import TextArea from '~/components/atoms/TextArea.vue'
export default {
  components: {
    UsersLink,
    LinkCard,
    LikeButton,
    Button,
    Comment,
    TextArea
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
  data () {
    return {
      links: '',
      content: '',
      comments: [],
      alreadylike: Boolean,
      likeCount: 0,
      openComments: false,
      openCommentslog: false
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
        if (error.response === 404) {
          this.notFound = true
        }
      })
  },
  methods: {
    async likepost () {
      console.log('post.vue.likepost')
      await axios
        .post('/v1/likes', {
          userid: this.currentUser.id,
          post_id: this.post.id
        })
        .then(() => {
          this.alreadylike = true
          this.likeCount++
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
      axios
        .post('/v1/likes/likenone', {
          user_id: this.currentUser.id,
          post_id: this.post.id
        })
        .then(() => {
          this.alreadylike = false
          this.likeCount--
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
        })
    },
    async getcreatepost () {
      await this.$axios
        .$get(`v1/posts/${this.post.id}/comments`)
        .then((res) => {
          this.comments = res
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
