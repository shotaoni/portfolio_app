<template>
  <v-card class="user-links-box">
    <v-card-title>
      <v-row justify="center">
        メニュー
      </v-row>
    </v-card-title>
    <div>
      <v-card-text>
        <v-row justify="center">
          <v-btn
            outlined
            block
            @click="$emit('openlikeposts')"
          >
            <v-icon>
              mdi-table-heart
            </v-icon>
            いいねした投稿
          </v-btn>
        </v-row>
      </v-card-text>
    </div>
    <div v-if="currentUser.id === user.id">
      <v-card-text>
        <v-row justify="center">
          <v-btn
            outlined
            block
            @click="$emit('opentimeline')"
          >
            <v-icon>
              mdi-clock-time-three-outline
            </v-icon>
            タイムライン
          </v-btn>
        </v-row>
      </v-card-text>
    </div>
    <v-card-text>
      <v-row justify="center">
        <v-btn
          outlined
          block
          @click="$emit('openusertimeline')"
        >
          <v-icon>
            mdi-comment-account-outline
          </v-icon>
          {{ user.name }}さんの投稿
        </v-btn>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    user: {}
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  }
}
</script>

<style>
.user-links-box {
  margin-top: 24px
}
</style>
