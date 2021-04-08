<template>
 <v-container>
  <v-row justify="center">
      <v-col xl="2" lg="3" sm="8" cols="12">
        <Menu
          @openPostFeed="openPostFeed"
          @openLikeRankingFeed="openLikeRankingFeed"
        />
      </v-col>
      <v-col xl="5" lg="7" sm="8" cols="12">
        <PostFeed
        v-if="openpostFeed && !openlikeRankingFeed"
        />
        <LikeRankingFeed
        v-if="!openpostFeed && !openlikeRankingFeed"
        />
      </v-col>
    </v-row>
 </v-container>
</template>

<script>
import Menu from '~/components/molecules/Menu.vue'
import PostFeed from '~/components/organisms/posts/PostFeed.vue'
import LikeRankingFeed from '~/components/organisms/LikeRankingFeed.vue'
export default {
  components: {
    PostFeed,
    LikeRankingFeed,
    Menu
  },
  data () {
    return {
      openpostFeed: true,
      openlikeRankingFeed: false
    }
  },
  methods: {
    openPostFeed () {
      this.openpostFeed = true
      this.openlikeRankingFeed = false
    },
    openLikeRankingFeed () {
      this.openpostFeed = false
      this.openlikeRankingFeed = false
    }
  }
}
</script>

<style>
</style>
