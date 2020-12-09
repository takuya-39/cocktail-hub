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
      height="70px"
    >
      <!-- ヘッダーナビアイコン -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-app-bar-nav-icon
            x-large
            class="nav-icon-btn ml-5"
            color="white"
            v-bind="attrs"
            v-on="on"
            @click="switchDrawer"
          >
          </v-app-bar-nav-icon>
        </template>
        <span>メニューを開く</span>
      </v-tooltip>

      <!-- 新規投稿アイコン -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            class="posts-new-btn ml-10"
            v-bind="attrs"
            v-on="on"
            @click="$router.push('/posts/new').catch((e) => {}), reload()"
          >
            <v-icon color="white" large>
              mdi-plus-circle-outline
            </v-icon>
          </v-btn>
        </template>
        <span>投稿する</span>
      </v-tooltip>

      <!-- トップに戻るアイコン -->
      <v-tooltip
        bottom
        v-if="this.$route.path === '/'"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            class="ml-10 mt-2 go-top-btn"
            @click="$emit('goTop')"
            v-bind="attrs"
            v-on="on"
          >
            <v-icon
              large
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
      <v-toolbar-title
        class="font-weight-bold white--text display-1 mr-10"
        @click="$router.push('/').catch((e) => {}), reload()"
      >
        Cooktail Hub
      </v-toolbar-title>
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
      <ranking @switchRanking="switchRanking"></ranking>
    </v-dialog>

  </v-card>
</template>

<script>
import Drawer from "components/drawer.vue";
import Explanation from "components/explanation.vue";
import Ranking from "components/ranking.vue";

export default {
  data: function () {
    return {
      menuDrawer: false,
      dialogExplanation: false,
      dialogRanking: false,
    };
  },
  components: {
    Drawer,
    Explanation,
    Ranking,
  },
  methods: {
    switchDrawer: function () {
      this.menuDrawer = !this.menuDrawer;
    },
    switchExplanation: function () {
      this.dialogExplanation = !this.dialogExplanation;
    },
    switchRanking: function () {
      this.dialogRanking = !this.dialogRanking;
    },
    reload() {
      this.$router.go({ path: this.$router.currentRoute.path, force: true });
    },
  },
};
</script>

<style scoped>
</style>
