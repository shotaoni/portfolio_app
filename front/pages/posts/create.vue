<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="create-post-h2">
        新規投稿
      </h2>
    </v-card-title>
    <v-form>
      <ValidationProvider ref="obs" v-slot="ObserverProps">
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
          <FileInput
          v-model="image"
          label="画像"
          accept="image/*"
          rules="size:5000"
          @change="onImagePicked"
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
      </ValidationProvider>
    </v-form>
  </v-card>
</template>

<script>
import axios from '@/plugins/axios'
import AddLink from '~/components/molecules/AddLink.vue'
import TextField from '~/components/atoms/TextField.vue'
import FileInput from '~/components/atoms/FileInput.vue'
export default {
  components: {
    TextField,
    AddLink,
    FileInput
  },
  data () {
    return {
      title: '',
      firstUrl: '',
      point: '',
      image: [],
      uploadImageUrl: ''
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
    onImagePicked (file) {
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.uploadImageUrl = fr.result
        })
      } else {
        this.uploadImageUrl = ''
      }
    },
    createPost () {
      this.$store.commit('setLoading', true)
      const formData = new FormData()
      console.log(formData)
      formData.append('image', this.image)
      console.log(formData)
      const config = {
        headers: {
          'content-type': 'multipart/form-data'
        }
      }
      axios
        .post('/v1/posts', {
          title: this.title,
          user_id: this.currentUser.id,
          links: this.links,
          point: this.point,
          formData,
          config
        })
        .then((res) => {
          console.log(res)
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
