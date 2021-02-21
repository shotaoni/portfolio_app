<template>
  <v-avatar :size="size">
    <img
      v-if="currentUser.avatar_url"
      :src="currentUser.avatar_url"
      alt="Avatar"
    >
    <img
      v-else
      src="~/assets/image/default-icon.png"
      alt="Avatar"
    >
  </v-avatar>
</template>

<script>
export default {
  props: {
    size: {
      type: Number,
      required: true
    },
    value: {
      user: {
        type: Object,
        required: true
      },
      type: null,
      default: ''
    }
  },
  data () {
    return {
      user: {}
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
