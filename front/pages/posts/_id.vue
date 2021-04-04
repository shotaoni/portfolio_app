<template>
  <v-container>
    <ErrorAnnounce
      :status="notFound"
    />
    <PostEditDialog
      :dialog="dialog"
      @closeDialog="dialog = false"
    />
    <div v-if="!notFound" class="posts-show-box">
      <v-card class="mx-auto mt-4 pa-3" width="400px">
        <v-card-title>
          <h2 class="post-show-title">
            {{ post.title }}
          </h2>
        </v-card-title>
        <div class="post-show-header px-2">
          <UsersLink
            :user="user"
            :post="post"
          />
          <div
            v-if="currentUser && currentUser.id === user.id"
            class="post-show-change-box"
          >
            <v-btn
              outlined
              fab
              small
              color="light-blue lighten-3"
              @click="dialog = !dialog"
            >
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
            <v-btn
              outlined
              fab
              small
              color="red lighten-3"
              @click="destroyPost"
            >
              <v-icon>mdi-delete-forever</v-icon>
            </v-btn>
          </div>
        </div>
        <div class="posts-point" style="white-space: pre-line">
          {{ point }}
        </div>
          <v-img
            v-if="image_url"
            :src="image_url"
            alt="Image"
          >
          </v-img>
          <div class="link-card">
        <LinkCard
          v-for="link in links"
          :key="link.id"
          :link="link"
        />
          </div>
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
      </v-card>
    </div>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import PostEditDialog from '~/components/organisms/PostEditDialog.vue'
import LinkCard from '~/components/molecules/LinkCard.vue'
import UsersLink from '~/components/molecules/UsersLink.vue'
import ErrorAnnounce from '~/components/molecules/ErrorAnnounce.vue'
import Comment from '~/components/molecules/Comment.vue'
import TextArea from '~/components/atoms/TextArea.vue'
import Button from '~/components/atoms/Button.vue'
import LikeButton from '~/components/atoms/LikeButton.vue'
export default {
  components: {
    ErrorAnnounce,
    UsersLink,
    LinkCard,
    PostEditDialog,
    Comment,
    TextArea,
    Button,
    LikeButton
  },
  data () {
    return {
      user: {},
      post: {},
      comments: [],
      content: '',
      point: '',
      links: '',
      notFound: false,
      dialog: false,
      image_url: '',
      alreadylike: false,
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
    this.isLiked()
    axios
      .get(`/v1/posts/${this.$route.params.id}`)
      .then((res) => {
        console.log(res)
        console.log(res.data)
        this.user = res.data.user
        this.post = res.data
        this.point = res.data.point
        this.links = res.data.links
        this.image_url = res.data.image_url
      })
      .catch((error) => {
        if (error.response.status === 404) {
          this.notFound = true
        }
      })
  },
  methods: {
    openDialog () {
      this.dialog = true
    },
    destroyPost () {
      this.$store.commit('setLoading', true)
      axios
        .delete(`/v1/posts/${this.$route.params.id}`, { id: this.user.id })
        .then((res) => {
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: '投稿を削除しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
          this.$router.push('/')
        })
    },
    async isLiked () {
      console.log('likebutton')
      console.log(this.post.id)
      console.log(this.currentUser.id)
      await this.$axios
        .$get('v1/likes', {
          params: {
            post_id: this.$route.params.id,
            userid: this.currentUser.id
          }
        })
        .then((res) => {
          console.log(res)
          if (!res) {
            this.alreadylike = false
          } else {
            this.alreadylike = true
          }
        })
    },
    async likepost () {
      console.log('post.vue.likepost')
      await this.$axios
        .post('/v1/likes', {
          userid: this.currentUser.id,
          post_id: this.$route.params.id
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
      this.$axios
        .post('/v1/likes/likenone', {
          user_id: this.currentUser.id,
          post_id: this.$route.params.id
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
      this.$axios
        .get('v1/likes', {
          params: {
            post_id: this.$route.params.id
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
          console.log(res)
          this.comments = res
        })
    },
    createComment () {
      this.openComments = false
      this.$axios
        .post('v1/comments', {
          content: this.content,
          post_id: this.$route.params.id,
          user_id: this.currentUser.id
        })
        .then(() => {
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
.link-card {
  margin-bottom: 24px
}

.posts-point {
  margin-top: 24px
}

.post-show-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
