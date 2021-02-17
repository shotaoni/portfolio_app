<template>
  <v-container>
    <ErrorAnnounce
    :status="notFound"
    />
    <div class="posts-show-box" v-if="!notFound">
      <v-card>
      <v-card-title>
        <h2 class="post-show-title">{{ post.title }}</h2>
      </v-card-title>
      <UsersLink
      :user="user"
      />
      </v-card>
    </div>
  </v-container>
</template>

<script>
import axios from '@/plugins/axios'
import UsersLink from '~/components/molecules/UsersLink.vue'
import ErrorAnnounce from '~/components/molecules/ErrorAnnounce.vue'
export default {
  components: {
    ErrorAnnounce,
    UsersLink
  },
  data () {
    return {
      user: {},
      post: {},
      notFound: false
    }
  },
  mounted () {
    axios
      .get(`/v1/posts/${this.$route.params.id}`)
      .then((res) => {
        this.user = res.data.user
        this.post = res.data
        console.log(res.data.user)
      })
      .catch((error) => {
        if (error.response.status === 404) {
          this.notFound = true
        }
      })
  }
}
</script>

<style>
</style>
