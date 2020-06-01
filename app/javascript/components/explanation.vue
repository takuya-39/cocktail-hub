<template>
  <v-card
    height="600px"
    color="#090422"
    class="white--text"
    tile
  >
    <v-toolbar
      color="#090422"
      dark
      flat
    >
      <!-- Cocktail Hubとは？ダイアログのタイトル -->
      <v-card-title class="font-weight-bold">
        Cocktail Hubとは？
      </v-card-title>

      <!-- 空白 -->
      <v-spacer></v-spacer>

      <!-- 閉じるボタン -->
      <v-btn
        icon
        large
        class="mr-3"
        @click="$emit('switchExplanation')"
      >
        <v-icon color="white">mdi-close</v-icon>
      </v-btn>
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