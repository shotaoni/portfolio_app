<template>
  <div class="user-link-box">
    <nuxt-link
      class="nuxt-link"
      :to="`/users/${user.id}`"
      style="color:#37474F"
    >
    <v-avatar size="32">
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
    <nuxt-link
      class="nuxt-link"
      :to="`/users/${user.id}`"
      style="color:#37474F"
    >
      {{ user.name }}
    </nuxt-link>
  </div>
</template>

<script>
export default {
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  props: {
    user: {
      type: Object,
      required: true
    },
    post: {
      type: Object,
      required: false
    }
  }
}
</script>

<style>
</style>
