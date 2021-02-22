<template>
  <v-card class="user-info-box">
    <v-card-text>
      <v-row justify="center">
        <v-avatar size="62">
              <img
                v-if="user.avatar_url"
                :src="user.avatar_url"
                alt="Avatar"
              >
              <img
                v-else
                src="~/assets/image/default-icon.png"
                alt="Avatar"
              >
            </v-avatar>
      </v-row>
      <v-row justify="center">
        <p class="user-info-box-name">
          {{ user.name }}
        </p>
      </v-row>
      <v-row justify="center">
        <nuxt-link
      class="nuxt-link"
      :to="`/users/following`"
      style="color:#37474F"
    >
      フォロー
      {{ user.following }}人
    </nuxt-link>
    <nuxt-link
      class="nuxt-link"
      :to="`/users/followed`"
      style="color:#37474F"
    >
      フォロワー
       {{ user.followed }}人
    </nuxt-link>
      </v-row>
      <v-row>
        <div class="user-info-box-profile">
          {{ user.profile }}
        </div>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  }
}
</script>

<style>
.user-info-box-name {
  padding-top: 12px;
  font-size: 18px;
  font-weight: bold
}

.user-info-box-profile {
  width: 90%;
  margin: 0 auto
}
</style>
