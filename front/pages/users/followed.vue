<template>
  <v-card class='forrowed-text'>
    <p>followedpe-zidayo</p>
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
