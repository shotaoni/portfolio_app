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
              rules="regex:https?://([\w-]+\.)+[\w-]+(/[\w- .?%&=]*)?"
              label="URL"
              :first-url.sync="firstUrl"
              :second-url.sync="secondUrl"
              :third-url.sync="thirdUrl"
              @input="firstUrl=$event"
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
    title: {
      type: String,
      default: ''
    },
    links: {
      type: Array
    },
    point: {
      type: String,
      default: ''
    },
    currentUser: {
      type: null,
      default: ''
    }
  },
  data () {
    return {
      dialogStatus: this.dialog,
      patchForTitle: '',
      patchForPoint: '',
      patchForFirstUrl: '',
      patchForSecondUrl: '',
      patchForThirdUrl: ''
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
    firstUrl: {
      get () {
        if (this.links) {
          this.patchForFirstUrl = this.links[0].og_url
          return this.links[0].og_url
        } else {
          return ''
        }
      },
      set (newVal) {
        this.patchForFirtstUrl = newVal
      }
    },
    secondUrl: {
      get () {
        if (this.links) {
          this.patchForSecondUrl = this.links[1].og_url
          return this.links[1].og_url
        } else {
          return ''
        }
      },
      set (newVal) {
        this.patchForSecondUrl = newVal
      }
    },
    thirdUrl: {
      get () {
        if (this.links) {
          this.patchForThirdUrl = this.links[2].og_url
          return this.links[2].og_url
        } else {
          return ''
        }
      },
      set (newVal) {
        this.patchForThirdUrl = newVal
      }
    },
    editLinks () {
      const editLinks = [this.patchForFirstUrl, this.patchForSecondUrl, this.patchForThirdUrl]
      return editLinks
    }
  },
  /* eslint-enable vue/no-side-effects-in-computed-properties */
  watch: {
    dialog (newVal) {
      this.dialogStatus = newVal
    }
  },
  methods: {
    closeDialog () {
      this.$emit('closeDialog')
    },
    updatePost () {
      this.$store.commit('setLoading', true)
      axios
        .patch(`/v1/posts/${this.$route.params.id}`, {
          title: this.patchForTitle,
          user_id: this.currentUser.id,
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
