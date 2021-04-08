<template>
  <v-card>
      <v-toolbar
        color="brown darken-1"
        dark
        flat
      >
        <v-toolbar-title>
          <v-icon class="mr-3">
            mdi-menu
          </v-icon>
          メニュー
        </v-toolbar-title>
      </v-toolbar>
      <v-list>
        <v-list-item-group
          color="brown lighten-2"
          mandatory
        >
          <v-list-item
            v-for="item in menuItems"
            :key="item.id"
            @click="menuClick(item.name)"
          >
            <v-list-item-content>
              <v-list-item-title>
                <v-icon class="mr-3">
                  {{ item.icon }}
                </v-icon>
                {{ item.title }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
  </v-card>
</template>

<script>
export default {
  data () {
    return {
      menuItems: [
        {
          title: 'みんなの投稿',
          name: 'openPostFeed',
          icon: 'mdi-post-outline'
        },
        {
          title: 'いいねが多い投稿',
          name: 'openLikeRankingFeed',
          icon: 'mdi-heart-multiple-outline'
        }
      ]
    }
  },
  methods: {
    menuClick (name) {
      this.$emit(`${name}`)
    }
  }
}
</script>

<style>
</style>
