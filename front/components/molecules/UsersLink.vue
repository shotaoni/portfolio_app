<template>
  <div class="user-link-box">
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
      required: true
    }
  }
}
</script>

<style>
</style>
