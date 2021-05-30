<template>
  <v-footer
    class="white--text"
    padless
    :color="footerColor"
  >
    <v-col
      class="text-center"
      cols="12"
    >
      {{ new Date().getFullYear() }} - <strong>Cocktail Hub</strong>
    </v-col>
  </v-footer>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
  components: {}
})

export default class Footer extends Vue {
  private footerColor: string = '#d1c4e9';
}
</script>

<style lang="scss" scoped>
</style>