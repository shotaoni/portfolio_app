<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="create-post-h2">新規投稿</h2>
    </v-card-title>
    <v-form>
      <ValidationObserver ref="obs" v-slot="ObserverProps">
        <div class="create-post-box">
          <TextField
          v-model="title"
          label="タイトル"
          rules="max:80|required"
          />
          <v-row justify="center">
            <v-btn
            color="light-blue lighten-3"
            class="white--text"
            @click="createPost"
            :disabled="ObserverProps.invalid || !ObserverProps.validated"
            >投稿
            </v-btn>
          </v-row>
        </div>
      </ValidationObserver>
    </v-form>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios'
import TextField from '~/components/atoms/TextField.vue'
export default {
  components: {
    TextField
  },
  data () {
    return {
      title: ''
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  methods: {
    createPost () {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/posts', {
          title: this.title,
          user_id: this.currentUser.id
        })
        .then((res) => {
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: '投稿が完了しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
          this.$router.push(`/posts/${res.data.id}`)
        })
    }
  }
}
</script>

<style>
.create-post-h2 {
  font-size: 24px
}
</style>
