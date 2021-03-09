<template>
  <v-container v-if="currentUser.id" @checked="checkedNotice">
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card>
          <v-toolbar
            color="brown"
            dark
            flat
          >
            <v-toolbar-title>
              <v-icon>
                mdi-bell-outline
              </v-icon>
              <span>通知一覧</span>
            </v-toolbar-title>
          </v-toolbar>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-row
                  v-for="(notice, index) in notices"
                  :key="index"
                  dense
                >
                  <v-col cols="12">
                    <v-col cols="2">
                      <nuxt-link
                        :to="`users/${notice.visitor.id}`"
                      >
                        <v-avatar size="30">
                          <img
                            v-if="notice.visitor.avatar_url"
                            :src="notice.visitor.avatar_url"
                            alt="Avatar"
                          >
                          <v-else
                            src="~/assets/image/default_icon.png"
                            alt="Avatar"
                          />
                        </v-avatar>
                      </nuxt-link>
                    </v-col>
                    <v-col cols="10">
                      <v-row>
                        <template
                          v-if="notice.action === 'comment'"
                        >
                          <nuxt-link
                            :to="`/posts/${notice.post_id}`"
                          >
                            あなたの投稿に{{ notice.visitor.name }}さんがコメントしました。
                          </nuxt-link>
                        </template>
                        <template
                          v-if="notice.action === 'comments'"
                        >
                          <nuxt-link
                            :to="`/posts/${notice.post_id}`"
                          >
                            投稿に{{ notice.visitor.name }}さんがコメントしました。
                          </nuxt-link>
                        </template>
                        <template
                          v-if="notice.action === 'like'"
                        >
                          <nuxt-link
                            :to="`/posts/${notice.post_id}`"
                          >
                            あなたの投稿に{{ notice.visitor.name }}さんがいいねしました。
                          </nuxt-link>
                        </template>
                        <template
                          v-if="notice.action === 'follow'"
                        >
                          <nuxt-link
                            :to="`/users/${notice.visitor.id}`"
                          >
                            あなたを{{ notice.visitor.name }}さんがフォローしました。
                          </nuxt-link>
                        </template>
                      </v-row>
                    </v-col>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
export default {
  data () {
    return {
      notices: []
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    },
    noticeLink () {
      if (this.notices.post_id) {
        return `/posts/${this.notices.post_id}`
      }
      return ''
    }
  },
  async mounted () {
    await axios
      .get('v1/notifications', {
        params: {
          user_id: this.$store.state.currentUser.id
        }
      })
      .then((res) => {
        this.notices = res.data
        console.log(res.data)
        console.log(this.notices)
      })
  },
  methods: {
    checkedNotice () {

    }
  }
}
</script>

<style>
</style>
