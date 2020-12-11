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
        <!-- Cocktail Hubとは？ダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
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
              class="mr-3"
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

      <v-container class="mt-5">
        <v-row class="justify-content-center">
          <v-col
            v-for="(post, index) in posts"
            :key="post.index"
            cols=10
          >

            <v-col cols=10 class="d-flex align-items-center mt-3">
              <!-- ランキング1位のアイコン -->
              <v-icon class="mdi-36px mr-5" color="#e6b422" v-if="index === 0">
                mdi-podium-gold
              </v-icon>
              <!-- ランキング2位のアイコン -->
              <v-icon class="mdi-36px mr-5" color="#c0c0c0" v-if="index === 1">
                mdi-podium-silver
              </v-icon>
              <!-- ランキング3位のアイコン -->
              <v-icon class="mdi-36px mr-5" color="#b87333" v-if="index === 2">
                mdi-podium-bronze
              </v-icon>
              <h3 class="text-bold text-monospace text-light">
                いいね数{{ index + 1 }}位
              </h3>
            </v-col>

            <v-card
              :class="[`post-${ post.id }`, `index-${ index }`]"
              @click="$router.push(`/posts/${ post.id }`).catch(e=>{}), $emit('switchRanking'), $emit('reload')"
            >
              <v-img
                class="align-end"
                height="200px"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                :src="post.image"
              >
                <v-card-title
                  class="grey--text text--lighten-1 body-3 font-italic"
                  v-text="post.title"
                >
                </v-card-title>
              </v-img>
            </v-card>

          </v-col>
        </v-row>
      </v-container>

    </v-container>

  </v-card>
</template>

<script>

import axios from 'axios'

export default {
  data: function () {
    return {
      posts: [],
    }
  },
  created() {
    let api_url = '/api/v1/rankings/';
    axios
      .get(api_url)
      .then(res => {
        this.posts = res.data
      })
      .catch(err => {
        this.loading = false;
        console.log(err);
        });
  },
}
</script>

<style scoped>
</style>