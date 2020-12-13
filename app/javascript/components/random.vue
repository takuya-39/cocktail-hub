<template>
  <v-card
    tile
    class="white--text"
    color="#090422"
    height="600px"
  >
    <v-container class="p-3">
      <v-toolbar
        dark
        flat
        color="#090422"
      >
        <!-- ランダムダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
          ランダム
        </v-card-title>

        <!-- 空白 -->
        <v-spacer></v-spacer>

        <!-- 閉じるボタン -->
        <v-tooltip bottom>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              icon
              large
              class="mt-5 mr-3"
              v-bind="attrs"
              v-on="on"
              @click="$emit('switchRandom')"
            >
              <v-icon color="white">mdi-close</v-icon>
            </v-btn>
          </template>
          <span>閉じる</span>
        </v-tooltip>
      </v-toolbar>

      <!-- 本文 -->
      <v-container class="row mx-2">
        <v-container class="col-12 text-monospace mt-15">
          <p></p>
        </v-container>
      </v-container>
    </v-container>

  </v-card>
</template>

<script>
export default {
  data: function () {
    return {
    }
  }
}
</script>

<style scoped>
</style>