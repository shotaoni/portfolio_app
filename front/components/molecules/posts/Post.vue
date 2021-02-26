<template>
  <v-card class="mx-auto mt-4 pa-3" width="400px">
    <v-card-title class="py-2">
      <nuxt-link :to="`/posts/${post.id}`" style="color:#263238; text-decoration:none;">
        <p>{{ post.title }}</p>
      </nuxt-link>
    </v-card-title>
    <v-card-text>
      <UsersLink
        :user="user"
        :post="post"
      />
      <div class="post-index-point mt-2">
        {{ post.point }}
      </div>
      <v-col cols="12" v-if="post.links">
        <LinkCard
          v-for="link in links"
          :key="link.id"
          :link="link"
        />
      </v-col>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios.js'
import LinkCard from '~/components/molecules/LinkCard.vue'
import UsersLink from '~/components/molecules/UsersLink.vue'
export default {
  components: {
    UsersLink,
    LinkCard
  },
  data () {
    return {
      links: ''
    }
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  mounted () {
    axios
      .get(`/v1/posts/${this.post.id}`)
      .then((res) => {
        this.links = res.data.links
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
.post-index-point {
  white-space: pre-line
}
</style>
