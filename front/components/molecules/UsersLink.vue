<template>
  <div class="user-link-box">
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
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object
    },
    post: {
      type: Object
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  }
}
</script>

<style>
</style>
