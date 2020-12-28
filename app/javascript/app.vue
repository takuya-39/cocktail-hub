<template>
  <v-app id="app">
    <app-header @goTop="goTop" @displaySearchForm="displaySearchForm" />
    <router-view :postSearchForm="postSearchForm" @displaySearchForm="displaySearchForm" />
    <app-footer />
  </v-app>
</template>

<script>

import AppHeader from 'components/app_header.vue'
import AppFooter from 'components/app_footer.vue'

export default {
  data() {
    return {
      postSearchForm: false,
    }
  },
  components: {
    'app-header': AppHeader,
    'app-footer': AppFooter,
  },
  methods: {
    goTop() {
      document. getElementById("go-top").scrollIntoView(true)
    },
    displaySearchForm() {
      this.postSearchForm = !this.postSearchForm;
    },
  }
}
</script>

<style scoped>
</style>
