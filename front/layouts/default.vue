<template>
  <v-app style="background-color: #ECEFF1;">
    <Flash />
    <Loading />
    <Header />
    <v-main>
      <v-container>
        <nuxt />
      </v-container>
    </v-main>
    <Footer />
  </v-app>
</template>

<script>
import Header from '../components/organisms/Header.vue'
import Footer from '../components/organisms/Footer.vue'
import Loading from '../components/atoms/Loading.vue'
import Flash from '../components/atoms/Flash.vue'
export default {
  name: 'Default',

  components: {
    Header,
    Footer,
    Loading,
    Flash
  }
}
</script>
