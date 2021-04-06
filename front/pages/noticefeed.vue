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
                          />
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
                          <p>コメント日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                          <div v-if="notice.checked">
                            既読
                          </div>
                          <div v-else>
                            未読
                          </div>
                        </template>
                        <template
                          v-if="notice.action === 'comments'"
                        >
                          <nuxt-link
                            :to="`/posts/${notice.post_id}`"
                          >
                            投稿に{{ notice.visitor.name }}さんがコメントしました。
                          </nuxt-link>
                          <p>コメント日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                          <div v-if="notice.checked">
                            既読
                          </div>
                          <div v-else>
                            未読
                          </div>
                        </template>
                        <template
                          v-if="notice.action === 'like'"
                        >
                          <nuxt-link
                            :to="`/posts/${notice.post_id}`"
                          >
                            あなたの投稿に{{ notice.visitor.name }}さんがいいねしました。
                          </nuxt-link>
                          <p>投稿日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                          <div v-if="notice.checked">
                            既読
                          </div>
                          <div v-else>
                            未読
                          </div>
                        </template>
                        <template
                          v-if="notice.action === 'follow'"
                        >
                          <nuxt-link
                            :to="`/users/${notice.visitor.id}`"
                          >
                            あなたを{{ notice.visitor.name }}さんがフォローしました。
                          </nuxt-link>
                          <p>フォロー日時: {{ $moment(notice.created_at).format('YYYY年MM月DD日 HH時mm分') }}</p>
                          <div v-if="notice.checked">
                            既読
                          </div>
                          <div v-else>
                            未読
                          </div>
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
        v-if="morePost"
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
      morePost: true
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
        console.log(res)
        this.notices = res.data
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
