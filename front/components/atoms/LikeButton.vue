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
import axios from '@/plugins/axios'
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
      console.log('likebutton')
      await axios
        .get('v1/likes', {
          params: {
            post_id: this.post.id,
            userid: this.currentUser.id
          }
        })
        .then((res) => {
          console.log(res.data)
          if (!res.data) {
            this.alreadylike = false
          } else {
            this.alreadylike = true
          }
        })
    }
  }
}
</script>

<style>
</style>
