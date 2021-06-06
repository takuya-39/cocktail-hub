<template>
  <!-- 全体 -->
  <v-card
    tile
    :max-width="headerMaxWidth"
  >
    <!-- スマホでない場合 -->
    <div v-show="!judgmentMobile">
      <!-- ヘッダー -->
      <v-app-bar
        class="white--text"
        fixed
        :color="defaultHeaderColor"
        :height="defaultHeaderHeight"
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
                :color="headerIconColor"
                :size="headerIconSize"
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
              class="ml-15 posts-search-btn"
              icon
              v-bind="attrs"
              v-on="on"
              @click="displaySearchForm()"
            >
              <v-icon
                :color="headerIconColor"
                :size="headerIconSize"
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
                :color="headerIconColor"
                :size="headerIconSize"
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
          :src="imagePath"
          :height="headerTitleHeight"
          @click="screenTransition(path = '/')"
        >
        </v-img>
      </v-app-bar>
    </div>
    <!-- スマホの場合 -->
    <div v-show="judgmentMobile">
      <!-- ヘッダー -->
      <v-app-bar
        class="white--text"
        fixed
        :color="mobileHeaderColor"
        :height="mobileHeaderHeight"
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
                :color="headerIconColor"
                :size="headerIconSize"
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
              class="ml-15 posts-search-btn"
              icon
              v-bind="attrs"
              v-on="on"
              @click="displaySearchForm()"
            >
              <v-icon
                :color="headerIconColor"
                :size="headerIconSize"
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
                :color="headerIconColor"
                :size="headerIconSize"
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
          :src="imagePath"
          :height="headerTitleHeight"
          @click="screenTransition(path = '/')"
        >
        </v-img>
      </v-app-bar>
    </div>
    <!-- ドロワー -->
    <v-navigation-drawer
      class="font-weight-bold"
      fixed
      temporary
      :color="drawerColor"
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
        @screenTransition="screenTransition()"
        v-model="menuDrawer"
      />
    </v-navigation-drawer>

    <!-- Cocktail Hubとは？ダイアログ -->
    <v-dialog
      raised
      :width="dialogWidth"
      v-model="dialogExplanation"
    >
      <ExplanationDialog
        :dialogExplanation="dialogExplanation"
        @switchExplanation="switchExplanation()"
      />
    </v-dialog>

    <!-- いいねランキングダイアログ -->
    <v-dialog
      raised
      :width="dialogWidth"
      v-model="dialogRanking"
    >
      <RankingDialog
        :dialogRanking="dialogRanking"
        @switchRanking="switchRanking()"
      />
    </v-dialog>

    <!-- ランダムダイアログ -->
    <v-dialog
      raised
      :width="dialogWidth"
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
import isMobile from 'ismobilejs';
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

  private headerMaxWidth: string = '100%';
  private defaultHeaderColor: string = '#d1c4e9';
  private defaultHeaderHeight: string = '100px';
  private mobileHeaderColor: string = '#d1c4e9';
  private mobileHeaderHeight: string = '200px';
  private headerIconColor: string = '#FFFFFF';
  private headerIconSize: string = '50px';
  private headerTitleHeight: string = '100px';
  private drawerColor: string = 'drawerColor';
  private dialogWidth: string = '80%';
  private imagePath: string = require('../../../../assets/images/app_title_image.png');
  private judgmentMobile: boolean = isMobile().phone;

  private screenTransition(path: string): void {
    this.$router.push(path).catch(e=>{});
    this.$router.go(0);
  }

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

  private goTop(): void {
    const position: HTMLElement = <HTMLInputElement>document.getElementById("go-top");
    position.scrollIntoView(true);
  }
};
</script>

<style lang="scss" scoped>
  .posts-search-btn {
    z-index: 10
  }

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