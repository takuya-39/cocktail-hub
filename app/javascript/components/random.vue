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
        <v-container>
          <v-card
              class="random-link"
              @click="$router.push(`/posts/${ random }`).catch(e=>{}), $emit('switchRandom'), $emit('reload')"
            >
              <v-img
                class="align-end"
                height="200px"
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

<script>

import axios from 'axios'

export default {
  data: function () {
    return {
      imagePath: require('../../assets/images/question_image.jpg'),
      posts: [],
      random: [],
    }
  },
  created() {
    let api_url = '/api/v1/posts/';
    axios
      .get(api_url)
      .then(res => {
        this.posts = res.data
        this.randomLink()
      })
      .catch(err => {
        this.loading = false;
        console.log(err);
        });
  },
  methods: {
    randomLink: function () {
      this.random = 1 + Math.floor( Math.random() * this.posts.length );
    },
  }
}
</script>

<style scoped>
</style>