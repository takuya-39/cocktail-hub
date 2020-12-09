<template>
  <v-card
    tile
    color="#e6e6fa"
    height="600px"
  >
    <v-container class="p-3">
      <v-toolbar
        dark
        flat
        color="#e6e6fa"
      >
        <!-- Cocktail Hubとは？ダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15">
          いいねランキング
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
              @click="$emit('switchRanking')"
            >
              <v-icon color="white">mdi-close</v-icon>
            </v-btn>
          </template>
          <span>閉じる</span>
        </v-tooltip>
      </v-toolbar>



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