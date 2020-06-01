<template>
  <v-app id="app">
    <app-header />
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
}
</script>

<style scoped>
</style>
