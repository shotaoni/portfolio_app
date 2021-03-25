<template>
  <div>
    <v-btn
      v-if="this.alreadylike && currentUser"
      icon
      outlined
      color="red"
      @click="$emit('likepostnone'); alreadylike = false"
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
      @click="$emit('likepost'); alreadylike = true"
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
      type: Object
    },
    user: {
      type: Object
    }
  },
  data () {
    return {
      alreadylike: false
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.isLiked()
  },
  methods: {
    async isLiked () {
      console.log(this)
      console.log(this.user)
      console.log(this.post.id)
      console.log(this.$store.state)
      console.log('likebutton', this.$store.state.currentUser)
      await this.$axios
        .$get('v1/likes', {
          params: {
            post_id: this.post.id,
            userid: this.currentUser.id
          }
        })
        .then((res) => {
          console.log(res)
          if (!res) {
            this.alreadylike = false
          } else {
            this.alreadylike = true
          }
          console.log(res)
        })
    }
  }
}
</script>

<style>
</style>
