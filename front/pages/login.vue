<template>
  <v-card class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h1 class="signup-title">
        ログイン
      </h1>
    </v-card-title>
    <v-card-text>
      <ValidationObserver>
        <v-form>
          <p v-if="error" class="errors">
            {{ error }}
          </p>
          <TextField
            v-model="email"
            label="メールアドレス"
            rules="max:255|required|email"
          />
          <TextField
            v-model="password"
            label="パスワード"
            rules="required|min:6"
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            vid="password"
            @click:append="show1 = !show1"
          />
          <v-row justify="center">
            <v-btn
              color="light-blue lighten-3"
              class="mx-auto white--text mt-4"
              @click="login"
            >
              ログイン
            </v-btn>
          </v-row>
        </v-form>
      </ValidationObserver>
    </v-card-text>
  </v-card>
</template>

<script>
import { setUser } from '@/plugins/auth-check.js'
import firebase from '@/plugins/firebase'
import TextField from '~/components/atoms/TextField.vue'
export default {
  components: {
    TextField
  },
  data () {
    return {
      email: '',
      password: '',
      show1: false,
      error: ''
    }
  },
  methods: {
    login () {
      this.$store.commit('setLoading', true)
      firebase
        .auth()
        .signInWithEmailAndPassword(this.email, this.password)
        .then((res) => {
          console.log(res)
          console.log(res.user)
          console.log(this.$store)
          setUser(res.user, this.$store)
          this.$store.commit('setFlash', {
            status: true,
            message: 'ログインしました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 2000)
          this.$router.push('/')
        })
        .catch((error) => {
          this.error = ((code) => {
            switch (code) {
              case 'auth/user-not-found':
                return 'メールアドレスが間違っています'
              case 'auth/wrong-password':
                return '※パスワードが正しくありません'
            }
          })(error.code)
          this.$store.commit('setLoading', false)
        })
    }
  }
}
</script>

<style>
</style>
