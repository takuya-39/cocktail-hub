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
            label="投稿検索ワードを入力"
            v-model="keyword"
          >
            {{ filter }}
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
  data: function() {
    return {
      posts: [],
      displayPosts: [],
      page: 1,
      pageSize: 18,
      length: 0,
      keyword: '',
      sample: '',
    };
  },
  props: ['postSearchForm'],
  created() {
    let api_url = '/api/v1/posts/';
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

  // postsの数:      28
  // page:           1,  今いるページ
  // pageSize:       18, 表示する投稿の数
  // length:         0,  ページネーションの長さ
  // this.length = Math.ceil(this.posts.length/this.pageSize);
        // *pageSize割るpostsの個数で出た値を小数点繰り上げてlengthに代入
        // *50/20=2.5=3 3をlengthに代入
        // つまりpostsの数が50の時はlengthは3になる、、、70の時は4になる
  // this.displayPosts = this.posts.slice(this.pageSize*(this.page -1), this.pageSize*(this.page));
        // *20*0=0 20*1=20 ○○を0~20に分けたものをdisplayPostsに代入



  computed: {
    filteredPosts: function() {
      console.log('computed発火 filteredPosts')
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
    filteredPosts: function() {
      // 常に適用

      this.length = Math.ceil(this.posts.length/this.pageSize);
      // Math.ceilは小数点以下を繰り上げた数を返す(3.6なら4になる)
      // ( length )に( posts(28) )割る( pageSize(18) ) === 2
            // 28/18 === 1.5555555~ === 2

      // つまり( this.length )には 2 が入る
      // this.length === 2


      this.displayPosts = this.posts.slice(this.pageSize*(this.page -1), this.pageSize*(this.page));
      this.displayPosts = this.posts.slice(0, 18)
            page === 1と仮定
      a1,   18かける(pageの番号から1引いたもの) === ○○
            a1 === 18 かける 0 === 0
      a2,   18かける(pageの番号) === ○○
            a2 === 18 かける 1 === 18
      posts全体のa1からa2まで配列に組み込みdisplayPostsに代入
            displayPosts === 1ならpostsの 0〜18, 2ならpostsの 19〜36

      let displayPosts = [];
      // displayPostsをリセット

      for(let i in this.displayPosts) {
        let post = this.displayPosts[i];
        if(post.title.indexOf(this.keyword) !== -1 ||
          post.genre.indexOf(this.keyword) !== -1) {
          displayPosts.push(post);

          // this.lengthをリセットして表示する

          全てのpostsを取得
          全てのpostsを表示
          ページネーションはpostsの数分を表示

          検索で出ただけのpostsを取得
          検索で出ただけのpostsを表示
          ページネーションは検索で出た分を表示
        }
      }
    return displayPosts;
    },
  },
  methods: {
    pageChange: function(page) {
      this.displayPosts = this.posts.slice(this.pageSize*(page -1), this.pageSize*(page));
      // displayPosts = displayPosts || posts
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