<template>
  <div class="profile-box">
    <h3 class="edit-h3">名前</h3>
    <TextArea
    v-model="name"
    :rules="rules"
    :label="label"
    v-bind="$attrs"
    />
    <v-row justify="end">
      <v-btn
      color="light-blue lighten-3"
      class="white--text profile-message-btn"
      @click="changeUsersProfile"
      >変更
      </v-btn>
    </v-row>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
import TextArea from '~/components/atoms/TextArea.vue'
export default {
  components: {
    TextArea
  },
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    value: {
      type: null
    },
    label: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      profile: ''
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  methods: {
    changeUsersProfile () {
      const user = {
        profile: this.profile
      }
      this.$store.commit('setLoading', true)

      axios
        .patch(`/v1/users/${this.currrentUser.id}`, { user })
        .then((res) => {
          this.profile = res.data.profile
          this.$store.commit('setUserProfile', res.data.profile)
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: 'プロフィールを編集しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
        })
    }
  },
  watch: {
    profile (newProfile) {
      this.$emit('input', newProfile)
    },
    value (newProfile) {
      this.profile = newProfile
    }
  }
}
</script>

<style>
.profile-box {
  margin-top: 24px;
  padding-top: 16px;
  border-top: 1px dashed#B3E5FC
}

.profile-message-btn {
  margin-top: 16px
}
</style>
