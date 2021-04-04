<template>
  <v-card flat>
    <v-card-title>
      ユーザを探す
    </v-card-title>
    <v-card-text>
      <v-text-field
        v-model="userword"
        hint="ユーザ名を入力してください"
      >
        <v-icon slot="prepend">
          mdi-magnify
        </v-icon>
      </v-text-field>
    </v-card-text>
    <UsersLink
      v-for="(user, $index) in users"
      :key="$index"
      :user="user"
    />
  </v-card>
</template>

<script>
import _ from 'lodash'
import axios from '@/plugins/axios'
import UsersLink from '~/components/molecules/UsersLink.vue'
export default {
  components: {
    UsersLink
  },
  data () {
    return {
      users: [],
      userword: ''
    }
  },
  watch: {
    userword () {
      if (this.userword) {
        this.delayFunc()
      } else {
        this.users = []
      }
    }
  },
  created () {
    this.delayFunc = _.debounce(this.search, 500)
  },
  methods: {
    search () {
      axios
        .get('v1/users', {
          params: {
            name: this.userword
          }
        })
        .then((res) => {
          this.users = res.data
        })
    }
  }
}
</script>

<style>
</style>
