<template>
  <v-card class="user-links-box">
    <v-card-title>
      <h2>メニュー</h2>
    </v-card-title>
    <v-card-text>
      <v-row justify="center">
      <v-btn
      @click="$emit('openlikeposts')"
      >
    いいねした投稿
      </v-btn>
      </v-row>
    </v-card-text>
    <v-card-text>
      <v-row justify="center">
      <v-btn
      >
    タイムライン
      </v-btn>
      </v-row>
    </v-card-text>
    <v-card-text>
      <v-row justify="center">
      <v-btn
      >
    通知一覧
      </v-btn>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
}
</script>

<style>
.user-links-box {
  margin-top: 24px
}
</style>
