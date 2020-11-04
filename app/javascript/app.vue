<template>
  <v-app id="app">
    <app-header @goTop="goTop"/>
    <router-view />
    <app-footer />
  </v-app>
</template>

<script>

import AppHeader from 'components/app_header.vue'
import AppFooter from 'components/app_footer.vue'

export default {
  data: function () {
    return {
    }
  },
  components: {
    'app-header': AppHeader,
    'app-footer': AppFooter,
  },
  methods: {
    goTop: function() {
      document. getElementById("go-top").scrollIntoView(true)
    },
  }
}
</script>

<style scoped>
</style>
