<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="500px"
    presistent
  >
    <v-card width="500px" class="mx-auto">
      <v-toolbar flat>
        <v-toolbar-title>編集</v-toolbar-title>
        <v-spacer />
        <v-btn
          icon
          @click="closeDialog"
        >
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-form>
        <ValidationObserver ref="obs" v-slot="{ invalid }">
          <div class="post-edit-box mt-2 pa-3">
            <TextField
              v-model="viewTitle"
              label="タイトル"
              rules="max:50|required"
            />
            <AddLink
              v-model="viewFirstUrl"
              rules="regex:https?://([\w-]+\.)+[\w-]+(/[\w- .?%&=]*)?"
              label="URL"
              :first-url.sync="firstUrl"
            />
            <TextArea
              v-model="viewPoint"
              label="説明"
              rules="max:140|required"
              :counter="140"
            />
            <v-row justify="center">
              <v-btn
                color="light-blue lighten-3"
                class="white--text"
                :disabled="invalid"
                @click="updatePost"
              >
                編集
              </v-btn>
            </v-row>
          </div>
        </ValidationObserver>
      </v-form>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from '@/plugins/axios'
import TextField from '~/components/atoms/TextField.vue'
import TextArea from '~/components/atoms/TextArea.vue'
import AddLink from '~/components/molecules/AddLink.vue'
export default {
  components: {
    TextField,
    TextArea,
    AddLink
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    },
    currentUser: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      title: '',
      links: [],
      point: '',
      firstUrl: '',
      userid: '',
      dialogStatus: this.dialog,
      patchForTitle: '',
      patchForPoint: '',
      patchForFirstUrl: ''
    }
  },
  /* eslint-disable vue/no-side-effects-in-computed-properties */
  computed: {
    viewTitle: {
      get () {
        this.patchForTitle = this.title
        return this.title
      },
      set (newVal) {
        this.patchForTitle = newVal
      }
    },
    viewPoint: {
      get () {
        this.patchForPoint = this.point
        return this.point
      },
      set (newVal) {
        this.patchForPoint = newVal
      }
    },
    viewFirstUrl: {
      get () {
        if (this.firstUrl) {
          this.patchForFirstUrl = this.links[0].url
          return this.links[0]
        } else {
          return ''
        }
      },
      set (newVal) {
        this.patchForFirtstUrl = newVal
      }
    },
    editLinks () {
      const editLinks = [this.firstUrl]
      return editLinks
    }
  },
  watch: {
    async dialog (newVal) {
      this.dialogStatus = newVal
      if (this.dialogStatus) {
        const res = await axios.get(`/v1/posts/${this.$route.params.id}`)
        this.title = res.data.title
        this.point = res.data.point
        this.firstUrl = res.data.links[0].url
        this.links[0] = res.data.links[0]
        this.userid = res.data.user.id
      }
    }
  },
  currentUser () {
    return this.$store.state.currentUser
  },
  /* eslint-enable vue/no-side-effects-in-computed-properties */
  methods: {
    closeDialog () {
      this.$emit('closeDialog')
    },
    updatePost () {
      this.$store.commit('setLoading', true)
      axios
        .patch(`/v1/posts/${this.$route.params.id}`, {
          title: this.patchForTitle,
          user_id: this.userid,
          links: this.editLinks,
          point: this.patchForPoint
        })
        .then((res) => {
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: '投稿を編集しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
          this.$router.push('/')
        })
    }
  }
}
</script>

<style>
</style>
