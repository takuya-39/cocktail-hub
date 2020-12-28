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
        <!-- Cocktail Hubとは？ダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
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
              class="mt-5 mr-3"
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
      <v-container class="row mx-2">
        <v-container class="col-12 text-monospace mt-15">
          <h5>「これにあれを加えてみると美味しいのかな？」</h5>
        </v-container>
        <v-container class="col-12 text-monospace mt-2">
          <h5>
            Cocktail Hubとはあなたが作った<br>
            オリジナルのカクテルを沢山の人にシェアできるアプリです。
          </h5>
        </v-container>
        <v-container class="col-12 text-monospace mt-2">
          <h5>
            あなただけのアイデアを、あなただけの組み合わせを探してみませんか？<br>
            まずは好奇心のおもむくままに様々なカクテルをご自身で作成してみてください！
          </h5>
        </v-container>
        <v-container class="col-12 text-monospace mt-2">
          <h4>あなたが作ったオリジナルカクテルをみんなと共有してみましょう！</h4>
        </v-container>
      </v-container>
    </v-container>

  </v-card>
</template>

<script>
export default {
  data() {
    return {
    }
  }
}
</script>

<style scoped>
</style>