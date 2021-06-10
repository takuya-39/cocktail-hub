<template>
  <v-card
    class="white--text"
    tile
    :color="explanationDialogColor"
    :height="explanationDialogHeight"
  >
    <v-container class="p-3">
      <v-toolbar
        dark
        flat
        :color="explanationDialogColor"
      >
        <!-- Cocktail Hubとは？ダイアログのタイトル -->
        <v-card-title class="display-2 font-weight-bold mt-15 ml-3">
          Cocktail Hubとは？
        </v-card-title>
        <!-- 空白 -->
        <v-spacer></v-spacer>
        <!-- スマートフォンでない場合 -->
        <div v-if="!judgmentMobile">
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
                  :color="defaultCloseButtonColor"
                  :size="defaultCloseButtonSize"
                >
                  mdi-close
                </v-icon>
              </v-btn>
            </template>
            <span>閉じる</span>
          </v-tooltip>
        </div>
        <!-- スマートフォンの場合 -->
        <div v-if="judgmentMobile">
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
                  :color="mobileCloseButtonColor"
                  :size="mobileCloseButtonSize"
                >
                  mdi-close
                </v-icon>
              </v-btn>
            </template>
            <span>閉じる</span>
          </v-tooltip>
        </div>
      </v-toolbar>
      <!-- 本文 -->
      <v-container class="row mx-5 mt-5">
        <v-container class="col-12 mt-15 focus-in-1">
          <h5>「これにあれを加えてみると美味しいのかな？」</h5>
        </v-container>
        <v-container class="col-12 mt-5 focus-in-2">
          <h5>
            Cocktail Hubとはあなたが作った<br>
            オリジナルのカクテルを沢山の人にシェアできるアプリです。
          </h5>
        </v-container>
        <v-container class="col-12 mt-5 focus-in-3">
          <h5>
            あなただけのアイデアを、あなただけの組み合わせを探してみませんか？<br>
            まずは好奇心のおもむくままに様々なカクテルをご自身で作成してみてください！
          </h5>
        </v-container>
        <v-container class="col-12 mt-5 focus-in-4">
          <h4>あなたが作ったオリジナルカクテルをみんなと共有してみましょう！</h4>
        </v-container>
      </v-container>
    </v-container>

  </v-card>
</template>

<script lang="ts">
import { Component, Vue, Prop, Emit } from 'vue-property-decorator';
import isMobile from 'ismobilejs';

@Component({
  components: {}
})

export default class ExplanationDialog extends Vue {
  @Prop(Boolean) public dialogExplanation!: Boolean;

  @Emit('switchExplanation')
  private switchExplanation(): void {
    this.dialogExplanation = !this.dialogExplanation;
  }

  private explanationDialogColor: string = '#090422';
  private explanationDialogHeight: string = '600px';
  private defaultCloseButtonColor: string = '#ffffff';
  private defaultCloseButtonSize: string = '50px';
  private mobileCloseButtonColor: string = '#ffffff';
  private mobileCloseButtonSize: string = '100px';
  private judgmentMobile: boolean = isMobile().phone;
}
</script>

<style lang="scss" scoped>
  .focus-in-1 {
    -webkit-animation: focus-in-1 1.5s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
            animation: focus-in-1 1.5s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
  }

  .focus-in-2 {
    -webkit-animation: focus-in-2 3s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
            animation: focus-in-2 3s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
  }

  .focus-in-3 {
    -webkit-animation: focus-in-3 4.5s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
            animation: focus-in-3 4.5s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
  }

  .focus-in-4 {
    -webkit-animation: focus-in-4 6s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
            animation: focus-in-4 6s cubic-bezier(0.550, 0.085, 0.680, 0.530) both;
  }

  @-webkit-keyframes focus-in-1 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @keyframes focus-in-1 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @-webkit-keyframes focus-in-2 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @keyframes focus-in-2 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @-webkit-keyframes focus-in-3 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @keyframes focus-in-3 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @-webkit-keyframes focus-in-4 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }

  @keyframes focus-in-4 {
    0% {
      -webkit-filter: blur(12px);
              filter: blur(12px);
      opacity: 0;
    }
    100% {
      -webkit-filter: blur(0px);
              filter: blur(0px);
      opacity: 1;
    }
  }
</style>