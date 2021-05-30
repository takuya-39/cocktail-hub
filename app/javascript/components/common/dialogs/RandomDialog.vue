<template>
  <v-card
    tile
    color="#d1c4e9"
  >
    <v-container class="p-3">
      <v-toolbar
        dark
        flat
        color="#d1c4e9"
      >
        <!-- ランダムダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
          ランダム
        </v-card-title>

        <!-- 空白 -->
        <v-spacer></v-spacer>

        <!-- 閉じるボタン -->
        <v-tooltip bottom>
          <template #activator="{ on, attrs }">
            <v-btn
              icon
              class="mt-5 mr-3"
              v-bind="attrs"
              v-on="on"
              @click="switchRandom()"
            >
              <v-icon
                size="50px"
                color="white"
              >
                mdi-close
              </v-icon>
            </v-btn>
          </template>
          <span>閉じる</span>
        </v-tooltip>
      </v-toolbar>

      <!-- 導入文 -->
      <v-container class="row mx-2">
        <v-container class="col-12 text-monospace mt-10">
          <h5>
            下の？ボタンを押すと<br>
            ランダムで選ばれた投稿の詳細ページに移動します。<br>
            適当に決めたい時、友人とお家飲みの際に遊びで、など<br>
            今日のお供をランダムに決めてみましょう。
          </h5>
        </v-container>
        <v-container class="col-12 text-monospace">
          <h4>
            あなたが今日つくるのは↓
          </h4>
        </v-container>

        <!-- ？ボタン -->
        <v-container>
          <v-card
              class="random-link"
              @click="routerRandom(), switchRandom()"
            >
              <v-img
                class="align-end"
                height="250px"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                :src="imagePath"
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

  private imagePath: string =  require('../../../../assets/images/question_image.jpg');
  private random: number = 0;
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

  private routerRandom(): void {
    this.$router.push(`/posts/${ this.random }`).catch(e=>{});
    this.$router.go(0);
  }

  private created(): void {
    this.getPosts();
  }
}
</script>

<style lang="scss" scoped>
</style>