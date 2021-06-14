<template>
  <v-card
    tile
    :color="randomDialogColor"
  >
    <v-container class="p-3">
      <v-toolbar
        dark
        flat
        :color="randomDialogColor"
      >
        <!-- ランダムダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
          ランダム
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
                @click="switchRandom()"
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
                @click="switchRandom()"
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
      <!-- 導入文 -->
      <v-container class="row mx-2">
        <v-container class="col-12 mt-10 focus-in-1">
          <h5>
            下の？ボタンを押すと<br>
            ランダムで選ばれた投稿の詳細ページに移動します。
          </h5>
        </v-container>
        <v-container class="focus-in-2">
          <h5>
            適当に決めたい時、友人とお家飲みの際に遊びで、など<br>
            今日のお供をランダムに決めてみましょう。
          </h5>
        </v-container>
        <v-container class="col-12 focus-in-3">
          <h4>
            あなたが今日つくるのは↓
          </h4>
        </v-container>
        <!-- ？ボタン -->
        <v-container>
          <v-card
              class="random-link random-card"
              @click="screenTransition(path = `/posts/${ random }`), switchRandom()"
            >
              <v-img
                class="align-end"
                :src="imagePath"
                :height="questionImageHeight"
                :gradient="questionImageGradient"
              >
              </v-img>
            </v-card>
        </v-container>
      </v-container>
    </v-container>

  </v-card>
</template>

<script lang="ts">
import { Component, Vue, Prop, Emit } from 'vue-property-decorator';
import axios from 'axios';
import isMobile from 'ismobilejs';
import { PostsData } from '@/types/@types/LibraryComponent';

@Component({
  components: {}
})

export default class RandomDialog extends Vue {
  @Prop(Boolean) public dialogRandom!: Boolean;

  @Emit('switchRandom')
  private switchRandom(): void {
    this.dialogRandom = !this.dialogRandom;
  }

  private randomDialogColor: string = '#d1c4e9';
  private defaultCloseButtonColor: string = '#ffffff';
  private defaultCloseButtonSize: string = '50px';
  private mobileCloseButtonColor: string = '#ffffff';
  private mobileCloseButtonSize: string = '100px';
  private questionImageHeight: string = '250px';
  private questionImageGradient: string = 'to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)';
  private imagePath: string =  require('../../../../assets/images/question_image.jpg');
  private random: number = 1;
  private judgmentMobile: boolean = isMobile().phone;
  private postsData: Array<PostsData> = [];

  private getPosts(): void {
    let api_url = '/api/v1/posts/';
    axios
      .get(api_url)
      .then(res => {
        this.postsData = res.data;
        this.randomNumber();
      })
      return;
  }

  private randomNumber(): void {
    this.random = 1 + Math.floor( Math.random() * this.postsData.length );
  }

  private screenTransition(path: string): void {
    this.$router.push(path).catch(e=>{});
    this.$router.go(0);
  }

  private created(): void {
    this.getPosts();
  }
}
</script>

<style lang="scss" scoped>
  .random-card {
    display: inline-block;
    transition-duration: 1s;
    transition-property: border-radius;
    &:hover {
      border-radius: 5em !important;
    }
  }

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
</style>