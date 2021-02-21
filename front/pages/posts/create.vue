<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="create-post-h2">
        新規投稿
      </h2>
    </v-card-title>
    <v-form>
      <ValidationObserver ref="obs" v-slot="ObserverProps">
        <div class="create-post-box">
          <TextField
            v-model="title"
            label="タイトル"
            rules="max:80|required"
          />
          <AddLink
            rules="regex:https?://([\w-]+\.)+[\w-]+(/[\w- .?%&=]*)?"
            label="URL"
            :first-url.sync="firstUrl"
          />
          <TextArea
            v-model="point"
            label="説明"
            rules="max:140|required"
            :counter="140"
          />
          <v-row justify="center">
            <v-btn
              color="light-blue lighten-3"
              class="white--text"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
              @click="createPost"
            >
              投稿
            </v-btn>
          </v-row>
        </div>
      </ValidationObserver>
    </v-form>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios'
import AddLink from '~/components/molecules/AddLink.vue'
import TextField from '~/components/atoms/TextField.vue'
export default {
  components: {
    TextField,
    AddLink
  },
  data () {
    return {
      title: '',
      firstUrl: '',
      point: ''
    }
  },
  fetch ({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser) => {
        if (!newUser) {
          return redirect('/login')
        }
      }
    )
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    },
    links () {
      const links = [this.firstUrl]
      return links
    }
  },
  methods: {
    createPost () {
      this.$store.commit('setLoading', true)
      axios
        .post('/v1/posts', {
          title: this.title,
          user_id: this.currentUser.id,
          links: this.links,
          point: this.point
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
