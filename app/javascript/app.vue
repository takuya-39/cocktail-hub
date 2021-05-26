<template>
  <v-app id="app">
    <AppHeader @goTop="goTop" @displaySearchForm="displaySearchForm" />
    <router-view :postSearchForm="postSearchForm" @displaySearchForm="displaySearchForm" />
    <AppFooter />
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import AppHeader from '@/components/common/header/AppHeader.vue';
import AppFooter from '@/components/common/footer/AppFooter.vue';

@Component({
  components: {
    AppHeader,
    AppFooter
  }
})

export default class App extends Vue {
  private postSearchForm: boolean = false;
  // private goTop(): void {
  //   document. getElementById("go-top").scrollIntoView(true)
  // }
  private displaySearchForm(): void {
    this.postSearchForm = !this.postSearchForm;
  }
}
</script>

<style lang="scss" scoped>
</style>
