<template>
  <div>
    <v-btn
      v-if="alreadylike && currentUser"
      icon
      outlined
      color="red lighten-1"
      @click="$emit('likepostnone')"
    >
      <v-icon>
        mdi-heart
      </v-icon>
    </v-btn>
    <v-btn
      v-else
      icon
      outlined
      color="gray"
      @click="$emit('likepost')"
    >
      <v-icon>
        mdi-heart
      </v-icon>
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      default: null
    },
    user: {
      type: Object,
      default: null
    },
    alreadylike: {
      type: Boolean
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
