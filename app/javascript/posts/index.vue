<template>
  <v-app id="app">

    <!-- コンテンツ全体 -->
    <v-card color="#060211" tile>

      <v-container fluid class="mx-auto" max-width="100%" id="go-top">

      <!-- 投稿検索アイコン -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            x-large
            btn-primary
            class="m-4 bg-primary search-post-btn"
            @click="displaySearchForm"
            v-bind="attrs"
            v-on="on"
            fixed
            bottom
            right
            style="z-index: 10;"
          >
            <v-icon color="white" large>
              mdi-magnify
            </v-icon>
          </v-btn>
          </template>
        <span>検索フォームを開く</span>
      </v-tooltip>

      <!-- 投稿検索フォーム -->
      <v-form v-show="postSearchForm" @submit.prevent>
        <v-container
          rounded
          fluid
          class="mt-1 mb-3 app-color-light"
        >
          <v-row>

          <!-- 投稿検索フォームタイトル -->
            <v-col>
              <h4
                class="mt-3 ml-5 text-monospace"
              >
                投稿を検索する
              </h4>
            </v-col>

            <!-- 閉じるボタン -->
            <v-col class="d-flex justify-content-end">
              <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    icon
                    large
                    class="mr-3"
                    v-bind="attrs"
                    v-on="on"
                    @click="displaySearchForm"
                  >
                    <v-icon color="white">mdi-close</v-icon>
                  </v-btn>
                </template>
                <span>閉じる</span>
              </v-tooltip>
            </v-col>
          </v-row>

          <!-- 投稿検索入力フォーム -->
          <v-text-field
            filled
            rounded
            class="pt-4 text-monospace"
            label="投稿検索ワードを入力"
            v-model="keyword"
          >
          </v-text-field>
        </v-container>
      </v-form>

        <v-row dense>
          <v-col
            v-for="post in filteredPosts"
            :key="post.index"
            cols=12 sm=6 md=6 lg=4
          >

            <!-- (それぞれの投稿カード) -->
            <v-card
              @click="$router.push(`/posts/${post.id}`).catch(e=>{}), reload()"
              class="post"
            >
              <!-- (投稿カードのイメージ) -->
              <v-img
                v-bind:src="post.image"
                class="align-end"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                height="250px"
              >
                <!-- (投稿カードのタイトル) -->
                <v-card-title
                  v-text="post.title"
                  class="grey--text text--lighten-1 body-3 font-italic"
                >
                </v-card-title>
              </v-img>
            </v-card>

          </v-col>
        </v-row>

      <!-- ページネーション -->
      <v-pagination
        v-model="page"
        :length="length"
        @input="pageChange"
      >
      </v-pagination>
      </v-container>
    </v-card>

  </v-app>
</template>


<script>

import axios from 'axios'

export default {
  data: function() {
    return {
      posts: [],
      displayPosts: [],
      filterPosts: [],
      page: 1,
      pageSize: 20,
      length:0,
      keyword: '',
      postSearchForm: false,
    };
  },
  created() {
    let api_url = '/api/v1/posts/';
    axios
      .get(api_url)
      .then(res => {
        this.posts = res.data
        this.length = Math.ceil(this.posts.length/this.pageSize);
        this.displayPosts = this.posts.slice(this.pageSize*(this.page -1), this.pageSize*(this.page));
      })
      .catch(err => {
        this.loading = false;
        console.log(err);
        });
  },
  computed: {
    filteredPosts: function() {
      let displayPosts = [];
      for(let i in this.displayPosts) {
        let post = this.displayPosts[i];
        if(post.title.indexOf(this.keyword) !== -1 ||
          post.genre.indexOf(this.keyword) !== -1) {
          displayPosts.push(post);
        }
      }
    return displayPosts;
    },
  },
  methods: {
    pageChange: function(pageNumber) {
      this.displayPosts = this.posts.slice(this.pageSize*(pageNumber -1), this.pageSize*(pageNumber));
    },
    displaySearchForm: function() {
      this.postSearchForm = !this.postSearchForm;
    },
    reload() {
      this.$router.go({path: this.$router.currentRoute.path, force: true});
    },
  },
}
</script>

<style scoped>
</style>