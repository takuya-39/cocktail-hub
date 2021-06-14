<template>
  <div>
    <!-- スマートフォンでない場合 -->
    <div v-if="!judgmentMobile">
      <v-footer
        class="white--text"
        padless
        :color="defaultFooterColor"
        :height="defaultFooterHeight"
      >
        <v-col
          class="text-center"
          cols="12"
        >
          {{ new Date().getFullYear() }} - <strong>Cocktail Hub</strong>
        </v-col>
      </v-footer>
    </div>
    <!-- スマートフォンの場合 -->
    <div v-if="judgmentMobile">
      <v-footer
        class="white--text"
        padless
        :color="mobileFooterColor"
        :height="mobileFooterHeight"
      >
        <v-col
          class="text-center"
          cols="12"
        >
          {{ new Date().getFullYear() }} - <strong>Cocktail Hub</strong>
        </v-col>
      </v-footer>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import isMobile from 'ismobilejs';

@Component({
  components: {}
})

export default class Footer extends Vue {
  private defaultFooterColor: string = '#d1c4e9';
  private defaultFooterHeight: string = '50px';
  private mobileFooterColor: string = '#d1c4e9';
  private mobileFooterHeight: string = '100px';

  private judgmentMobile: boolean = isMobile().phone;
}
</script>

<style lang="scss" scoped>
</style>