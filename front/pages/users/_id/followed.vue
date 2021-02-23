<template>
  <v-card class="mx-auto mt-4 pa-3" width="400px">
    <v-card-title class="py-2">
    </v-card-title>
    <v-card-text>
      <div class="post-index-point mt-2">
        {{ users }}
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios.js'
export default {
  data () {
    return {
      users: Object,
      required: false
    }
  },
  mounted () {
    axios
      .get('v1/users')
      .then((res) => {
        this.users = res.data
        console.log(this.users[0].id) // 1
      })
  }
}
</script>

<style>
</style>
