<template>
  <v-app id="app">

    <!-- コンテンツ全体 -->
    <v-card
      tile
      color="#060211"
    >
      <v-container
        fluid
        id="go-top"
        class="mx-auto"
        max-width="100%"
      >

      <!-- 新規投稿アイコン -->
      <v-tooltip bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            x-large
            fixed
            right
            bottom
            class="m-5 posts-new-btn"
            style="background-color: #c1c1ff; z-index: 10;"
            v-bind="attrs"
            v-on="on"
            @click="$router.push('/posts/new').catch((e) => {}), reload()"
          >
            <v-icon
              x-large
              color="white"
            >
              mdi-plus-circle-outline
            </v-icon>
          </v-btn>
        </template>
        <span>投稿する</span>
      </v-tooltip>

      <!-- 投稿検索フォーム -->
      <v-form
        class="posts-search-form"
        v-show="postSearchForm"
        @submit.prevent
      >
        <v-container
          fluid
          rounded
          class="mt-1 mb-3 app-color-light"
        >
          <v-row>

          <!-- 投稿検索フォームタイトル -->
            <v-col>
              <h4 class="text-monospace mt-3 ml-5">
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
                    @click="$emit('displaySearchForm')"
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
            id="posts-search-form"
            class="text-monospace pt-4"
            label="タイトルやジャンルを入力してください"
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
              :class="[`post-${post.id}`]"
              @click="$router.push(`/posts/${post.id}`).catch(e=>{}), reload()"
            >
              <!-- (投稿カードのイメージ) -->
              <v-img
                class="align-end"
                height="250px"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                :src="post.image"
              >
                <!-- (投稿カードのタイトル) -->
                <v-card-title
                  class="grey--text text--lighten-1 body-3 font-italic"
                  v-text="post.title"
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
  data() {
    return {
      posts: [],
      displayPosts: [],
      page: 1,
      pageSize: 18,
      length: 0,
      keyword: '',
    };
  },
  props: ['postSearchForm'],
  created() {
    this.getPosts();
  },
  computed: {
    filteredPosts() {
      let displayPosts = [];
      for(let i in this.displayPosts) {
        let post = this.displayPosts[i];
        if(post.title.indexOf(this.keyword) !== -1 || post.genre.indexOf(this.keyword) !== -1) {
          displayPosts.push(post);
        }
      }
      return displayPosts;
    }
  },
  methods: {
    getPosts() {
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
    pageChange(page) {
      this.displayPosts = this.posts.slice(this.pageSize*(page -1), this.pageSize*(page));
    },
    reload() {
      this.$router.go({path: this.$router.currentRoute.path, force: true});
    },
  },
}
</script>

<style scoped>
.posts-search-form {
  position: sticky;
  top: 80px;
  z-index: 1;
}
</style>