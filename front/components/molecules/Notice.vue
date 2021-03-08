<template>
  <div v-if="notice" @click="$emit('closeField')">
    <v-row class="notice-item">
      <v-col cols="2">
        <nuxt-link
        :to="noticeUserLink"
        class="no-link-style"
        >
          <v-avatar size="30">
            <img
            v-if="notice.action_user.avatar_url"
            :src="notice.action_user.avatar_url"
            >
            <v-else
            src="~/assets/image/default_icon.png"
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
          v-if="notice.noticeable_type === 'Comment'"
          >
          あなたの投稿に{{ notice.action_user.screen_name }}さんがコメントしました。
          </template>
          <template
          v-if="notice.like_type === 'post'"
          >
          あなたの投稿に{{ notice.action_user.screen_name }}さんがいいねしました。
          </template>
          <template
          v-if="notice.noticeable_type === 'Relationship'"
          >
          あなたを{{ notice.action_user.screen_name }}さんがフォローしました。
          </template>
        </v-row>
        </nuxt-link>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    notices: {
      type: Object,
      required: true
    }
  },
  computed: {
    noticeLink () {
      if (this.notices.post_id) {
        return `/posts/${this.notices.post_id}`
      } else if (this.notices.notificeable_type === 'Relationship') {
        return `/users/${this.notices.action_user_id}`
      }
      return ''
    },
    noticeUserLink () {
      return `/users/${this.notices.action_user_id}`
    }
  }
}
</script>

<style>
.notice-item {
  border-bottom: 1px solid #e8e8e8;
}
.no-link-style {
  color: inherit;
  text-decoration: none;
}
</style>
