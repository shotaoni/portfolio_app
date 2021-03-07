<template>
  <v-app-bar color="brown lighten-1" dark app fixed>
    <v-toolbar-title>
      <n-link to="/" style="color:white; text-decoration:none;">
        <h1 class="app-title">
          Tante.
        </h1>
      </n-link>
    </v-toolbar-title>
    <v-spacer />
    <div class="header-list">
      <div v-if="!currentUser" class="before-login-box">
        <UsersAvatar
          :size="36"
          :user="user"
        />
        <v-btn
          to="/login"
          text
          color="white"
          :outlined="true"
          small
        >
          ログイン
        </v-btn>
        <v-btn
          to="/signup"
          text
          color="white"
          :outlined="true"
          small
        >
          新規登録
        </v-btn>
      </div>
      <div v-if="currentUser" class="after-login-box">
        <nuxt-link to="/notification">
          <v-btn
            small
            class="mr-2"
            :outlined="true"
          >
            <v-icon small>
              mdi-bell-outline
            </v-icon>
            通知
          </v-btn>
        </nuxt-link>
        <nuxt-link to="/search">
          <v-btn
            small
            class="mr-2"
            :outlined="true"
          >
            <v-icon small>
              mdi-magnify
            </v-icon>
            検索
          </v-btn>
        </nuxt-link>
        <v-btn
          to="/posts/create"
          class="mr-2"
          color="white"
          :outlined="true"
          small
        >
          <v-icon small>
            mdi-fountain-pen-tip
          </v-icon>投稿
        </v-btn>
        <v-menu offset-y dense nav>
          <template #activator="{ on, attrs }">
            <v-avatar size="32">
              <img
                v-if="currentUser.avatar_url"
                :src="currentUser.avatar_url"
                alt="Avatar"
                v-bind="attrs"
                v-on="on"
              >
              <img
                v-else
                src="~/assets/image/default-icon.png"
                alt="Avatar"
                v-bind="attrs"
                v-on="on"
              >
            </v-avatar>
          </template>
          <v-list dense>
            <v-list-item
              v-for="(link, l) in links"
              :key="l"
              :to="link.to"
              exact
            >
              <v-list-item-title>{{ link.name }}</v-list-item-title>
            </v-list-item>
          </v-list>
          <v-divider />
          <v-list dense>
            <v-list-item key="logout" @click="logOut">
              <v-list-item-title>ログアウト</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </div>
    </div>
  </v-app-bar>
</template>

<script>
import firebase from '@/plugins/firebase'
import UsersAvatar from '~/components/atoms/UsersAvatar.vue'
export default {
  components: {
    UsersAvatar
  },
  data () {
    return {
      value: false,
      user: {}
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    },
    links () {
      const links = [
        {
          name: 'マイページ',
          to: `/users/${this.currentUser.id}`
        },
        {
          name: 'アカウント編集',
          to: '/users/edit'
        },
        {
          name: 'プロフィール編集',
          to: '/users/profile'
        }
      ]
      return links
    },
    loggedIn () {
      return this.$store.state.loggedIn
    }
  },
  methods: {
    logOut () {
      firebase
        .auth()
        .signOut()
        .then(() => {
          this.$store.commit('setFlash', {
            status: true,
            message: 'ログアウトしました'
          })
          setTimeout(() => {
            this.$store.commit('setFlash', {})
          }, 1500)
          this.$router.push('/login')
        })
    }
  }
}
</script>

<style>
.app-title {
  margin-left: 200px;
  font-size: 1.5em;
  letter-spacing: 2px
}

.header-list {
  display: flex;
  margin-right: 200px
}

.before-login-box {
  display: flex
}

@media (max-width: 1024px) {
  .app-title {
    margin-left: 50px;
    font-size: 1.2em
  }
  .header-list {
    margin-right: 50px
  }
}

@media (max-width: 480px) {
  .app-title {
    margin-left: 0;
    font-size: 1em;
    letter-spacing: 1px
  }
  .header-list {
    margin-right: 0;
  }
}
</style>
