<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="7" lg="8" sm="10" cols="12">
        <v-card class="mx-auto">
          <v-toolbar
            color="brown"
            dark
            flat
          >
            <v-toolbar-title class="ml-3">
              検索する
            </v-toolbar-title>
          </v-toolbar>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            background-color="brown"
            color="white"
            slider-color="brown"
            icons-and-text
            show-arrows
          >
            <v-tab class="ma-0 pa-0">
              ユーザー
              <v-icon>
                mdi-account-search-outline
              </v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              投稿
              <v-icon>
                mdi-note-search-outline
              </v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              コメント
              <v-icon>
                mdi-comment-text-multiple-outline
              </v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items
            v-model="tab"
            touchless
          >
            <v-tab-item>
              <v-card flat>
                <SearchUsers />
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card flat>
                <SearchPosts />
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <v-card flat>
                <SearchComments />
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import SearchUsers from '~/components/molecules/SearchUsers.vue'
import SearchPosts from '~/components/molecules/SearchPosts.vue'
import SearchComments from '~/components/molecules/SearchComments.vue'
export default {
  components: {
    SearchUsers,
    SearchPosts,
    SearchComments
  },
  data () {
    return {
      tab: null
    }
  }
}
</script>

<style>
</style>
