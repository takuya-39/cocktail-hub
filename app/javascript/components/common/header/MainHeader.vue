<template>
  <!-- 全体 -->
  <v-card
    max-width="100%"
    tile
  >
    <!-- ヘッダー -->
    <v-app-bar
      class="white--text"
      color="#d1c4e9"
      height="100px"
      fixed
    >
      <!-- ヘッダーナビアイコン -->
      <v-tooltip bottom>
        <template #activator="{ on, attrs }">
          <v-btn
            class="ml-10 nav-icon-btn"
            icon
            v-bind="attrs"
            v-on="on"
            @click="switchDrawer()"
          >
            <v-icon
              color="white"
              size="50px"
            >
              mdi-menu
            </v-icon>
          </v-btn>
        </template>
        <span>メニューを開く</span>
      </v-tooltip>

      <!-- 投稿検索アイコン -->
      <v-tooltip
        bottom
        v-if="this.$route.path === '/'"
      >
        <template #activator="{ on, attrs }">
          <v-btn
            style="z-index: 10;"
            class="ml-15 posts-search-btn"
            icon
            v-bind="attrs"
            v-on="on"
            @click="displaySearchForm()"
          >
            <v-icon
              color="white"
              size="50px"
            >
              mdi-magnify
            </v-icon>
          </v-btn>
          </template>
        <span>検索フォームを開く</span>
      </v-tooltip>

      <!-- トップに戻るアイコン -->
      <v-tooltip
        bottom
        v-if="this.$route.path === '/'"
      >
        <template #activator="{ on, attrs }">
          <v-btn
            class="ml-15 mt-2 go-top-btn"
            icon
            v-bind="attrs"
            v-on="on"
            @click="goTop()"
          >
            <v-icon
              color="white"
              size="50px"
            >
              mdi-apple-keyboard-control
            </v-icon>
          </v-btn>
        </template>
        <span>ページトップへ戻る</span>
      </v-tooltip>

      <!-- 空白 -->
      <v-spacer></v-spacer>

      <!-- ヘッダータイトル -->
      <v-img
        class="app-title-image"
        height="100px"
        :src="imagePath"
        @click="routerRoot()"
      >
      </v-img>
    </v-app-bar>

    <!-- ドロワー -->
    <v-navigation-drawer
      class="font-weight-bold"
      color="white"
      fixed
      temporary
      v-model="menuDrawer"
    >
      <MainDrawer
        :dialogExplanation="dialogExplanation"
        :dialogRanking="dialogRanking"
        :dialogRandom="dialogRandom"
        @switchDrawer="switchDrawer()"
        @switchExplanation="switchExplanation()"
        @switchRanking="switchRanking()"
        @switchRandom="switchRandom()"
        v-model="menuDrawer"
      />
    </v-navigation-drawer>

    <!-- Cocktail Hubとは？ダイアログ -->
    <v-dialog
      width="80%"
      raised
      v-model="dialogExplanation"
    >
      <ExplanationDialog
        :dialogExplanation="dialogExplanation"
        @switchExplanation="switchExplanation()"
      />
    </v-dialog>

    <!-- いいねランキングダイアログ -->
    <v-dialog
      width="80%"
      raised
      v-model="dialogRanking"
    >
      <RankingDialog
        :dialogRanking="dialogRanking"
        @switchRanking="switchRanking()"
      />
    </v-dialog>

    <!-- ランダムダイアログ -->
    <v-dialog
      width="80%"
      raised
      v-model="dialogRandom"
    >
      <RandomDialog
        :dialogRandom="dialogRandom"
        @switchRandom="switchRandom()"
      />
    </v-dialog>
  </v-card>
</template>

<script lang="ts">
import { Component, Vue, Emit, Model } from 'vue-property-decorator';
import MainDrawer from "@/components/common/header/drawer/MainDrawer.vue";
import ExplanationDialog from "@/components/common/dialogs/ExplanationDialog.vue";
import RankingDialog from "@/components/common/dialogs/RankingDialog.vue";
import RandomDialog from "@/components/common/dialogs/RandomDialog.vue";

@Component({
  components: {
    MainDrawer,
    ExplanationDialog,
    RankingDialog,
    RandomDialog
  }
})

export default class MainHeader extends Vue {
  @Model('change', {type: Boolean}) public postSearchForm!: Boolean;

  @Emit('displaySearchForm')
  private displaySearchForm(): void {
    this.postSearchForm = !this.postSearchForm;
  }

  public menuDrawer: boolean = false;
  public dialogExplanation: boolean = false;
  public dialogRanking: boolean = false;
  public dialogRandom: boolean = false;

  private imagePath: string = require('../../../../assets/images/app_title_image.png');

  private switchDrawer(): void {
    this.menuDrawer = !this.menuDrawer;
  }

  private switchExplanation(): void {
    this.dialogExplanation = !this.dialogExplanation;
  }

  private switchRanking(): void {
    this.dialogRanking = !this.dialogRanking;
  }

  private switchRandom(): void {
    this.dialogRandom = !this.dialogRandom;
  }

  private routerRoot(): void {
    this.$router.push('/').catch(e=>{});
    this.$router.go(0);
  }

  private goTop(): void {
    const position: HTMLElement = <HTMLInputElement>document.getElementById("go-top");
    position.scrollIntoView(true);
  }
};
</script>

<style lang="scss" scoped>
  .app-title-image {
    width: 400px;
    position: absolute;
    right: 30px;
    z-index: 10;
  }
  @media (max-width: 780px) {
    .app-title-image {
      display: none;
    }
}
</style>