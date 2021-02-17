<template>
  <v-card v-if="status" class="mx-auto mt-5 pa-5" width="400px">
    <v-card-title>
      <h2 class="error-box">
        お探しのページは見つかりませんでした。
      </h2>
    </v-card-title>
    <v-card-text>
      <v-row justify="center">
        <v-btn
          color="light-blue lighten-3"
          class="white--text"
          to="/"
        >
          ホームへ戻る
        </v-btn>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    status: {
      type: Boolean,
      required: true
    }
  }
}
</script>

<style>
@media (max-width: 1024px) {
}
@media (max-width: 480px) {
  .error-box {
    font-size: 24px
  }
}
</style>
