<template>
  <v-container v-if="currentUser.id">
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
                  v-for="notice in notices"
                  :key="notice.id"
                  dense
                >
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
                        <img
                          v-else
                          src="~/assets/image/default-icon.png"
                          alt="Avatar"
                        >
                      </v-avatar>
                      {{ notice.visitor.name }}
                    </nuxt-link>
                  </v-col>
                  <v-col cols="10">
                    <template
                      v-if="notice.action === 'comment'"
                    >
                      <nuxt-link
                        :to="`/posts/${notice.post_id}`"
                      >
                        あなたの投稿に{{ notice.visitor.name }}さんがコメントしました。
                      </nuxt-link>
                      <p class="opacity-time">コメント日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                    </template>
                    <template
                      v-if="notice.action === 'comments'"
                    >
                      <nuxt-link
                        :to="`/posts/${notice.post_id}`"
                      >
                        投稿に{{ notice.visitor.name }}さんがコメントしました。
                      </nuxt-link>
                      <p class="opacity-time">コメント日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                    </template>
                    <template
                      v-if="notice.action === 'like'"
                    >
                      <nuxt-link
                        :to="`/posts/${notice.post_id}`"
                      >
                        あなたの投稿に{{ notice.visitor.name }}さんがいいねしました。
                      </nuxt-link>
                      <p class="opacity-time">投稿日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                    </template>
                    <template
                      v-if="notice.action === 'follow'"
                    >
                      <nuxt-link
                        :to="`/users/${notice.visitor.id}`"
                      >
                        あなたを{{ notice.visitor.name }}さんがフォローしました。
                      </nuxt-link>
                      <p class="opacity-time">フォロー日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                    </template>
                    <v-divider />
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-container>
        </v-card>
        <v-row justify="center">
          <v-btn
            v-if="moreNotice"
            color="brown lighten-2"
            class="mt-4 white--text more-loading"
            @click="moreLoading"
          >
            記事読み込み
          </v-btn>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
export default {
  data () {
    return {
      notices: [],
      moreNotice: true,
      noticeCount: 0
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
        this.noticeCount = res.data.length
        if (res.data.length < 20) {
          this.moreNotice = false
        }
      })
  },
  methods: {
    async moreLoading () {
      const params = {
        offset: this.noticeCount,
        user_id: this.$store.state.currentUser.id
      }
      this.$store.commit('setLoading', true)
      await this.$axios
        .get('/v1/notifications', { params })
        .then((res) => {
          const addNotices = res.data
          this.notices = this.notices.concat(addNotices)
          this.noticeCount = this.notices.length
          if (addNotices.length < 20) {
            this.moreNotice = false
          } else {
            this.moreNotice = true
          }
          this.$store.commit('setLoading', false)
        })
    }
  }
}
</script>

<style>
.opacity-time {
  opacity: 0.7;
}
</style>
