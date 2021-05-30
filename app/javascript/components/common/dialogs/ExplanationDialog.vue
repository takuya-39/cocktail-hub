<template>
  <v-card
    class="white--text"
    color="#090422"
    height="600px"
    tile
  >
    <v-container class="p-3">
      <v-toolbar
        color="#090422"
        dark
        flat
      >
        <!-- Cocktail Hubとは？ダイアログのタイトル -->
        <v-card-title class="display-2 font-weight-bold mt-15 ml-3">
          Cocktail Hubとは？
        </v-card-title>

        <!-- 空白 -->
        <v-spacer></v-spacer>

        <!-- 閉じるボタン -->
        <v-tooltip bottom>
          <template #activator="{ on, attrs }">
            <v-btn
              class="mt-5 mr-3"
              icon
              v-bind="attrs"
              v-on="on"
              @click="switchExplanation()"
            >
              <v-icon
                color="white"
                size="50px"
              >
                mdi-close
              </v-icon>
            </v-btn>
          </template>
          <span>閉じる</span>
        </v-tooltip>
      </v-toolbar>

      <!-- 本文 -->
      <v-container class="row mx-5 mt-5">
        <v-container class="col-12 text-monospace mt-15">
          <h5>「これにあれを加えてみると美味しいのかな？」</h5>
        </v-container>
        <v-container class="col-12 text-monospace mt-5">
          <h5>
            Cocktail Hubとはあなたが作った<br>
            オリジナルのカクテルを沢山の人にシェアできるアプリです。
          </h5>
        </v-container>
        <v-container class="col-12 text-monospace mt-5">
          <h5>
            あなただけのアイデアを、あなただけの組み合わせを探してみませんか？<br>
            まずは好奇心のおもむくままに様々なカクテルをご自身で作成してみてください！
          </h5>
        </v-container>
        <v-container class="col-12 text-monospace mt-5">
          <h4>あなたが作ったオリジナルカクテルをみんなと共有してみましょう！</h4>
        </v-container>
      </v-container>
    </v-container>

  </v-card>
</template>

<script lang="ts">
import { Component, Vue, Prop, Emit } from 'vue-property-decorator';

@Component({
  components: {}
})

export default class ExplanationDialog extends Vue {
  @Prop(Boolean) public dialogExplanation!: Boolean;

  @Emit('switchExplanation')
  private switchExplanation(): void {
    this.dialogExplanation = !this.dialogExplanation;
  }
}
</script>

<style lang="scss" scoped>
</style>