<template>
 <v-container>
  <v-row justify="center">
      <v-col xl="2" lg="3" sm="8" cols="12">
        <Menu
          @openPostFeed="openPostFeed"
          @openLikeRankingFeed="openLikeRankingFeed"
          @openCommentPostFeed="openCommentPostFeed"
        />
      </v-col>
      <v-col xl="5" lg="7" sm="8" cols="12">
        <PostFeed
        v-if="openpostFeed && !openlikeRankingFeed && !opencommentPostFeed"
        />
        <LikeRankingFeed
        v-if="!openpostFeed && openlikeRankingFeed && !opencommentPostFeed"
        />
        <CommentPostFeed
        v-if="!openpostFeed && !openlikeRankingFeed && opencommentPostFeed"
        />
      </v-col>
    </v-row>
 </v-container>
</template>

<script>
import Menu from '~/components/molecules/Menu.vue'
import PostFeed from '~/components/organisms/posts/PostFeed.vue'
import LikeRankingFeed from '~/components/organisms/LikeRankingFeed.vue'
import CommentPostFeed from '~/components/organisms/CommentPostFeed.vue'
export default {
  components: {
    PostFeed,
    LikeRankingFeed,
    CommentPostFeed,
    Menu
  },
  data () {
    return {
      openpostFeed: true,
      openlikeRankingFeed: false,
      opencommentPostFeed: false
    }
  },
  methods: {
    openPostFeed () {
      this.openpostFeed = true
      this.openlikeRankingFeed = false
      this.opencommentPostFeed = false
    },
    openLikeRankingFeed () {
      this.openpostFeed = false
      this.openlikeRankingFeed = true
      this.opencommentPostFeed = false
    },
    openCommentPostFeed () {
      this.openpostFeed = false
      this.openlikeRankingFeed = false
      this.opencommentPostFeed = true
    }
  }
}
</script>

<style>
</style>
