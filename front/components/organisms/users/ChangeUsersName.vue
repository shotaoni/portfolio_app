<template>
  <ValidationObserver ref="obs" v-slot="ObserverProps">
    <div class="username-box">
      <h3 class="edit-h3">
        名前
      </h3>
      <TextField
        v-model="name"
        :rules="rules"
        :label="label"
        v-bind="$attrs"
      />
      <v-row justify="end">
        <v-btn
          color="light-blue lighten-3"
          class="white--text"
          :disabled="ObserverProps.invalid || !ObserverProps.validated"
          @click="changeUsersName"
        >
          変更
        </v-btn>
      </v-row>
    </div>
  </ValidationObserver>
</template>

<script>
import axios from '@/plugins/axios'
import TextField from '~/components/atoms/TextField.vue'
export default {
  components: {
    TextField
  },
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    value: {
      type: null,
      default: ''
    },
    label: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      name: ''
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  watch: {
    name (newName) {
      this.$emit('input', newName)
    },
    value (newName) {
      this.name = newName
    }
  },
  methods: {
    changeUsersName () {
      const user = {
        name: this.name
      }
      this.$store.commit('setLoading', true)

      axios
        .patch(`/v1/users/${this.currentUser.id}`, { user })
        .then((res) => {
          this.name = res.data.name
          this.$store.commit('setUserName', res.data.name)
          this.$store.commit('setLoading', false)
          this.$store.commit('setFlash', {
            status: true,
            message: '名前を変更しました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
        })
    }
  }
}
</script>

<style>
</style>
