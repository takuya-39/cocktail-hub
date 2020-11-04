<template>

  <!-- 全体 -->
  <v-card max-width="100%" tile>

    <!-- ヘッダー -->
    <v-app-bar
      class="white--text"
      color="#d1c4e9"
      height="70px"
      fixed
    >
      <!-- ヘッダーナビアイコン -->
      <v-app-bar-nav-icon
        @click="switchDrawer"
        class="ml-5 nav-icon"
        color="white"
        x-large
      >
      </v-app-bar-nav-icon>

      <!-- 新規投稿アイコン -->
      <v-btn
        icon
        class="ml-6 posts-new"
        @click="$router.push('/posts/new').catch(e=>{}), reload()"
      >
        <v-icon color="white" large>
          mdi-plus-circle-outline
        </v-icon>
      </v-btn>

      <!-- トップに戻るアイコン -->
      <v-btn
        icon
        class="ml-6 mt-2 go-top"
        @click="$emit('goTop')"
        v-if="this.$route.path === '/'"
      >
        <v-icon color="white" large>
          mdi-apple-keyboard-control
        </v-icon>
      </v-btn>

      <!-- 空白 -->
      <v-spacer></v-spacer>

      <!-- ヘッダータイトル -->
      <v-toolbar-title
        class="font-weight-bold white--text display-1 mr-10"
        @click="$router.push('/').catch(e=>{}), reload()"
      >
        Cooktail Hub
      </v-toolbar-title>
    </v-app-bar>

    <!-- ドロワー -->
    <v-navigation-drawer
      v-model="menuDrawer"
      temporary
      color="white"
      class="font-weight-bold"
      fixed
    >
      <drawer
        @switchDrawer="switchDrawer"
        @switchExplanation="switchExplanation"
        @switcSearch="switchSearch"
        @reload="reload"
      >
      </drawer>
    </v-navigation-drawer>

    <!-- 検索ダイアログ -->
    <v-dialog
      v-model="dialogSearch"
      width="80%"
      raised
    >
      <search @switchSearch="switchSearch"></search>
    </v-dialog>

    <!-- Cocktail Hubとは？ダイアログ -->
    <v-dialog
      v-model="dialogExplanation"
      width="80%"
      raised
    >
      <explanation @switchExplanation="switchExplanation"></explanation>
    </v-dialog>

  </v-card>
</template>

<script>

import Drawer from 'components/drawer.vue'
import Explanation from 'components/explanation.vue'
import Search from 'components/search.vue'

export default {
  data: function () {
    return {
      menuDrawer: false,
      dialogExplanation: false,
      dialogSearch: false,
    }
  },
  components: {
    Drawer,
    Explanation,
    Search,
  },
  methods: {
    switchDrawer: function() {
      this.menuDrawer = !this.menuDrawer
    },
    switchExplanation: function() {
      this.dialogExplanation = !this.dialogExplanation
    },
    switchSearch: function() {
      this.dialogSearch = !this.dialogSearch
    },
    reload() {
      this.$router.go({path: this.$router.currentRoute.path, force: true});
    },
  }
}
</script>

<style scoped>
</style>
