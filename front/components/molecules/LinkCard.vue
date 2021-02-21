<template>
  <div class="link-box">
    <v-card
      max-width="400"
      color="blue lighten-2"
      style="color:white;"
    >
      <v-img :src="og_image" height="150px" />
      <v-card-title class="pt-2 pb-2">
        {{ og_title }}
      </v-card-title>
      <v-card-actions>
        <v-btn
          color="white"
          text
          :href="og_url"
        >
          リンク先へ
        </v-btn>
        <v-spacer />
        <v-btn icon @click="show = !show">
          <v-icon color="white">
            {{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}
          </v-icon>
        </v-btn>
      </v-card-actions>
      <v-expand-transition>
        <div v-show="show">
          <v-divider />
          <v-card-text>
            <p>{{ og_description }}</p>
          </v-card-text>
        </div>
      </v-expand-transition>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    link: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      og_url: this.link.og_url,
      og_title: this.link.og_title,
      og_image: this.link.og_image,
      og_description: this.link.og_description,
      show: false
    }
  }
}
</script>

<style>
.link-box {
  margin-top: 24px;
}
</style>
