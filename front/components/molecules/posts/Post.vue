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
      />
      <div class="post-index-point mt-2">
        {{ post.point }}
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import UsersLink from '~/components/molecules/UsersLink.vue'
export default {
  components: {
    UsersLink
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
  }
}
</script>

<style>
.post-index-point {
  white-space: pre-line
}
</style>
