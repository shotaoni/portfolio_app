<template>
  <div>
    <v-badge
    color="orange"
    :value="count"
    :content="count"
    overlap
    >
      <v-icon
      @click="noticeField = !noticeField"
      style="color: white"
      >
      mdi-bell-outline
      </v-icon>
    </v-badge>
    <v-card v-if="noticeField" id="notice-field">
      <v-card-title id="notice-field-title">
        <span>通知</span>
        <v-spacer />
        <span @click="closeField">
          <nuxt-link
          to="/noticefeed"
          id="to-notices"
          >
          通知一覧
          </nuxt-link>
        </span>
      </v-card-title>
      <v-card-text>
        <Notice
        v-for="notice in notices"
        :key="notice.id"
        :notice="notice"
        @closeField="closeField"
        />
        <span v-if="!notices.length">通知はありません。</span>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
import Notice from '~/components/molecules/Notice.vue'
export default {
  components: {
    Notice
  },
  props: {
    value: {
      user: Object
    }
  },
  data () {
    return {
      count: 0,
      noticeField: false,
      notices: []
    }
  },
  computed: {
    currentUser () {
      return this.$store.state.currentUser
    }
  },
  mounted () {
    this.getNotice()
  },
  methods: {
    closeField () {
      this.noticeField = false
    },
    getNotice () {
      axios
        .get('v1/notifications', {
          params: {
            user_id: this.$store.state.currentUser.id
          }
        })
        .then((res) => {
          this.notices = res.data
          console.log(res.data)
        })
    }
  }
}
</script>

<style>
#notice-field-title {
  padding-top: 0px;
  font-size: 1.0em;
}
#notice-field {
  display: block;
  position: absolute;
  right: 400px;
  z-index: 1000;
  width: 320px;
  height: 480px;
  background-color: #fff;
  padding: 16px 0;
  border: 1px solid #ddd;
  border-radius: 3px;
  box-shadow: 0 0 8px 0 rgba(0,0,0,0.15);
  overflow-y: scroll;
}
#to-notices {
  color: inherit;
  text-decoration: none;
  font-size: 0.8em;
}
@media (max-width: 1024px) {
  #notice-field {
    top: 45px;
    right: 300px;
  }
}
@media (max-width: 480px) {
  #notice-field {
    top: 45px;
    right: 30px;
    width: 320px;
    height: 480px;
  }
}
</style>
