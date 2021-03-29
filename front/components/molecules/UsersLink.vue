<template>
  <div class="user-link-box">
    テスト
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    },
    post: {
      type: Object,
      required: true
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
