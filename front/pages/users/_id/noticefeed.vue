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
                dense
                v-for="(notice, index) in notices"
                :key="index"
                >
                <v-col cols="12">
                  <v-col cols="2">
                    <nuxt-link
                    :to="notice.noticeLink"
                    class="no-link-style"
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
                    <nuxt-link
                    :to="noticeLink"
                    class="no-link-style"
                    >
                    <v-row>
                      <template
                      v-if="notice.action === 'Comment'"
                      >
                      あなたの投稿に{{ notice.noticeVisitor }}さんがコメントしました。
                      </template>
                      <template
                      v-if="notice.action === 'post'"
                      >
                      あなたの投稿に{{ notice.noticeVisitor }}さんがいいねしました。
                      </template>
                      <template
                      v-if="notice.action === 'follow'"
                      >
                      あなたを{{ notice.noticeVisitor }}さんがフォローしました。
                      </template>
                    </v-row>
                    </nuxt-link>
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
    }
  },
  async mounted () {
    await this.getnotifications()
  },
  methods: {
    async getnotifications () {
      await axios
        .get('v1/notifications', {
          params: {
            user_id: this.$store.state.currentUser.id
          }
        })
    }
  }
}
</script>

<style>
</style>
