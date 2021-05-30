<template>
  <v-app id="app">
    <MainHeader
      v-model="postSearchForm"
      @displaySearchForm="displaySearchForm()"
    />
    <router-view
      v-model="postSearchForm"
      @displaySearchForm="displaySearchForm()"
    />
    <AppFooter />
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import MainHeader from '@/components/common/header/MainHeader.vue';
import AppFooter from '@/components/common/footer/AppFooter.vue';

@Component({
  components: {
    MainHeader,
    AppFooter
  }
})

export default class App extends Vue {
  public postSearchForm: boolean = false;

  private displaySearchForm(): void {
    this.postSearchForm = !this.postSearchForm;
  }
}
</script>

<style lang="scss" scoped>
</style>
