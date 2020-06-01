<template>
  <v-app id="app">
    <app-header />
    <router-view />
  </v-app>
</template>

<script>

import AppHeader from 'components/app_header.vue'

export default {
  data: function () {
    return {
    }
  },
  components: {
    'app-header': AppHeader,
  },
}
</script>

<style scoped>
</style>
