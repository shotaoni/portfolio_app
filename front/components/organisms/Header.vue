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
        <v-row>
          <nuxt-link to="/search">
            <v-btn
              small
              class="mr-2"
              :outlined="true"
            >
              <v-icon small class="mr-1">
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
            <v-icon small class="mr-1">
              mdi-fountain-pen-tip
            </v-icon>投稿
          </v-btn>
          <v-btn
            v-if="check"
            to="/noticefeed"
            class="mr-2"
            color="white"
            :outlined="true"
            small
          >
            <v-icon small class="mr-1">
              mdi-bell-outline
            </v-icon>通知一覧
          </v-btn>
          <v-btn
            v-else
            to="/noticefeed"
            class="mr-2"
            color="white"
            :outlined="true"
            small
            @click="check = true"
          >
            <v-icon small color="orange" class="mr-1 pekopeko">
              mdi-bell-outline
            </v-icon>通知があります！
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
        </v-row>
      </div>
    </div>
  </v-app-bar>
</template>

<script>
import firebase from '@/plugins/firebase'
export default {
  data () {
    return {
      value: false,
      user: {},
      check: true
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
  mounted () {
    this.$axios.$get('v1/notifications/unchecked', {
      params: {
        user_id: this.$store.state.currentUser.id
      }
    })
      .then((res) => {
        console.log(res)
        if (res === 0) {
          this.check = true
        } else {
          this.check = false
        }
      })
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

.pekopeko {
    animation: pekopeko 2s infinite;
}
@keyframes pekopeko {
    0% {
        top: 0px;
    }
    10% {
        top: 3px;
    }
    20% {
        top: 0px;
    }
    30% {
        top: 3px;
    }
    40% {
        top: 0px;
    }
}
</style>
