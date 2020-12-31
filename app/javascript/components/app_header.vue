<template>
  <!-- 全体 -->
  <v-card
    tile
    max-width="100%"
  >
    <!-- ヘッダー -->
    <v-app-bar
      fixed
      class="white--text"
      color="#d1c4e9"
      height="100px"
    >
      <!-- ヘッダーナビアイコン -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            class="ml-10 nav-icon-btn"
            v-bind="attrs"
            v-on="on"
            @click="switchDrawer"
          >
            <v-icon
              size="50px"
              color="white"
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
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            class="ml-15 posts-search-btn"
            style="z-index: 10;"
            v-bind="attrs"
            v-on="on"
            @click="$emit('displaySearchForm')"
          >
            <v-icon
              size="50px"
              color="white"
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
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            class="ml-15 mt-2 go-top-btn"
            v-bind="attrs"
            v-on="on"
            @click="$emit('goTop')"
          >
            <v-icon
              size="50px"
              color="white"
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
        @click="$router.push('/').catch((e) => {}), reload()"
      >
      </v-img>
    </v-app-bar>

    <!-- ドロワー -->
    <v-navigation-drawer
      temporary
      fixed
      class="font-weight-bold"
      color="white"
      v-model="menuDrawer"
    >
      <drawer
        @switchDrawer="switchDrawer"
        @switchExplanation="switchExplanation"
        @switchRanking="switchRanking"
        @switchRandom="switchRandom"
        @reload="reload"
      >
      </drawer>
    </v-navigation-drawer>

    <!-- Cocktail Hubとは？ダイアログ -->
    <v-dialog
      raised
      width="80%"
      v-model="dialogExplanation"
    >
      <explanation @switchExplanation="switchExplanation"></explanation>
    </v-dialog>

    <!-- いいねランキングダイアログ -->
    <v-dialog
      raised
      width="80%"
      v-model="dialogRanking"
    >
      <ranking
        @switchRanking="switchRanking"
        @reload="reload"
      >
      </ranking>
    </v-dialog>

    <!-- ランダムダイアログ -->
    <v-dialog
      raised
      width="80%"
      v-model="dialogRandom"
    >
      <random
        @switchRandom="switchRandom"
        @reload="reload"
      >
      </random>
    </v-dialog>

  </v-card>
</template>

<script>
import Drawer from "components/drawer.vue";
import Explanation from "components/explanation.vue";
import Ranking from "components/ranking.vue";
import Random from "components/random.vue";

export default {
  data() {
    return {
      imagePath: require('../../assets/images/app_title_image.png'),
      menuDrawer: false,
      dialogExplanation: false,
      dialogRanking: false,
      dialogRandom: false,
    };
  },
  components: {
    Drawer,
    Explanation,
    Ranking,
    Random,
  },
  methods: {
    switchDrawer() {
      this.menuDrawer = !this.menuDrawer;
    },
    switchExplanation() {
      this.dialogExplanation = !this.dialogExplanation;
    },
    switchRanking() {
      this.dialogRanking = !this.dialogRanking;
    },
    switchRandom() {
      this.dialogRandom = !this.dialogRandom;
    },
    reload() {
      this.$router.go({ path: this.$router.currentRoute.path, force: true });
    },
  },
};
</script>

<style
  lang="scss"
  scoped
>
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
