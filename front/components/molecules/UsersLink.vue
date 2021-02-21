<template>
  <div class="user-link-box">
    <UsersAvatar
      :size="36"
      :user="user"
    />
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
import UsersAvatar from '~/components/atoms/UsersAvatar.vue'
export default {
  components: {
    UsersAvatar
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  props: {
    user: {
      type: Object,
      required: true
    }
  }
}
</script>

<style>
</style>
