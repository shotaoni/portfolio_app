<template>
  <v-card class="user-info-box">
    <v-card-text>
      <v-row justify="center">
        <nuxt-link
          class="nuxt-link"
          :to="`/users/${user.id}`"
          style="color:#37474F"
        >
          <v-avatar size="62">
            <img
              v-if="user.avatar_url"
              :src="user.avatar_url"
              alt="Avatar"
            >
            <img
              v-else
              src="~/assets/image/default-icon.png"
              alt="Avatar"
            >
          </v-avatar>
        </nuxt-link>
      </v-row>
      <v-row justify="center">
        <nuxt-link
          class="nuxt-link"
          :to="`/users/${user.id}`"
          style="color:#37474F"
        >
          <p class="user-info-box-name">
            {{ user.name }}
          </p>
        </nuxt-link>
      </v-row>
      <v-row justify="center">
        <nuxt-link
          class="nuxt-link"
          :to="`/users/${user.id}/FollowingFeed`"
          style="color:#37474F"
        >
          フォロー
          {{ followinglength }}人
        </nuxt-link>
        <nuxt-link
          class="nuxt-link"
          :to="`/users/${user.id}/FollowerFeed`"
          style="color:#37474F"
        >
          フォロワー
          {{ followerslength }}人
        </nuxt-link>
        <v-col v-if="!(currentUser.id === user.id)" cols="12">
          <v-row justify="center">
            <v-btn
              v-if="!alreadyfollow"
              outlined
              color="primary"
              @click="follow(user)"
            >
              フォローする
            </v-btn>
            <v-btn
              v-else
              outlined
              color="white--text red"
              @click="unfollow(user)"
            >
              フォロー解除
            </v-btn>
          </v-row>
        </v-col>
      </v-row>
      <v-row justify="center">
        {{ user.profile }}
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios'
export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      followers: {},
      alreadyfollow: Boolean,
      followerslength: Number,
      followinglength: Number
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.getFollowRelationship()
    this.getFollowingnow()
    this.getFollowersnow()
  },
  methods: {
    getFollowingnow () {
      axios
        .get(`/v1/users/${this.$route.params.id}/following`)
        .then((res) => {
          this.followinglength = res.data.length
        })
    },
    getFollowersnow () {
      axios
        .get(`/v1/users/${this.$route.params.id}/followers`)
        .then((res) => {
          this.followerslength = res.data.length
        })
    },
    async getFollowRelationship () {
      await axios
        .get('/v1/relationships', {
          params: {
            userid: this.currentUser.id,
            followed_id: this.$route.params.id
          }
        })
        .then((res) => {
          if (!res.data) {
            this.alreadyfollow = false
          } else {
            this.alreadyfollow = true
          }
        })
    },
    follow (user) {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/relationships', {
          userid: this.currentUser.id,
          followed_id: user.id
        })
        .then((res) => {
          this.getFollowersnow()
          this.alreadyfollow = true
          this.getFollowRelationship()
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'フォローしました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 3000)
        })
    },
    unfollow (user) {
      this.$store.commit('setLoading', true)
      axios
        .post(`/v1/users/${this.$route.params.id}/unfollow`, {
          userid: this.currentUser.id,
          unfollowed_id: user.id
        })
        .then((res) => {
          this.getFollowersnow()
          this.alreadyfollow = false
          this.getFollowRelationship()
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'フォローを解除しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 3000)
        })
    }
  }
}
</script>

<style>
.user-info-box-name {
  padding-top: 12px;
  font-size: 18px;
  font-weight: bold
}

.user-info-box-profile {
  width: 90%;
  margin: 0 auto
}
</style>
