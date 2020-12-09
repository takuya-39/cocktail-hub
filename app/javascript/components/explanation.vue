<template>
  <v-card
    tile
    class="white--text"
    color="#090422"
    height="600px"
  >
    <v-toolbar
      dark
      flat
      color="#090422"
    >
      <!-- Cocktail Hubとは？ダイアログのタイトル -->
      <v-card-title class="font-weight-bold">
        Cocktail Hubとは？
      </v-card-title>

      <!-- 空白 -->
      <v-spacer></v-spacer>

      <!-- 閉じるボタン -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            large
            class="mr-3"
            v-bind="attrs"
            v-on="on"
            @click="$emit('switchExplanation')"
          >
            <v-icon color="white">mdi-close</v-icon>
          </v-btn>
        </template>
        <span>閉じる</span>
      </v-tooltip>
    </v-toolbar>

    <!-- 本文 -->
    <v-container>
      <p>Cocktail Hub</p>
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