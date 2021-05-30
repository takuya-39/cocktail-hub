<template>
  <v-app id="app">

    <!-- コンテンツ全体 -->
    <v-card
      color="#060211"
      tile
    >
      <v-container
        id="go-top"
        class="mx-auto"
        max-width="100%"
        fluid
      >

      <!-- 新規投稿アイコン -->
      <v-tooltip
        bottom
      >
        <template #activator="{ on, attrs }">
          <v-btn
            class="m-5 posts-new-btn"
            bottom
            fixed
            icon
            right
            v-bind="attrs"
            v-on="on"
            @click="routerPostsNew()"
          >
            <v-icon
              color="white"
              size="80px"
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
          class="mt-1 mb-3 app-color-light"
          fluid
          rounded
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
                <template #activator="{ on, attrs }">
                  <v-btn
                    class="mr-3"
                    icon
                    large
                    v-bind="attrs"
                    v-on="on"
                    @click="displaySearchForm()"
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
            id="posts-search-form"
            class="text-monospace pt-4"
            label="タイトルやジャンルを入力してください"
            filled
            rounded
            v-model="keyword"
          >
          </v-text-field>
        </v-container>
      </v-form>

      <v-row dense>
        <v-col
          v-for="post in filteredPosts"
          :key="post.id"
          cols=12
          sm=6
          md=6
          lg=4
        >

          <!-- (それぞれの投稿カード) -->
          <v-card
            class=""
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
      <!-- <v-pagination
        v-model="page"
        :length="length"
        @input="pageChange"
      >
      </v-pagination> -->
      </v-container>
    </v-card>
  </v-app>
</template>


<script lang="ts">
import { Component, Vue, Emit, Model } from 'vue-property-decorator';
import axios from 'axios';
import { PostsData } from '@/types/@types/LibraryComponent';


@Component({
  components: {}
})
export default class PostsIndex extends Vue {
  @Model('change', {type: Boolean}) public postSearchForm!: Boolean;

  @Emit('displaySearchForm')
  private displaySearchForm(): void {
    this.postSearchForm = !this.postSearchForm;
  }

  private keyword: string = '';
  private postsData: Array<PostsData> = [];

  // 以下ページネーション機能の修正までコメントアウト
  // private displayPosts: Array<PostsData> = [];
  // private page: number = 1;
  // private pageSize: number = 18;
  // private length: number = 0;

  private getPosts(): void {
    let api_url = '/api/v1/posts/';
    axios
      .get(api_url)
      .then(res => {
        this.postsData = res.data;
      })
      return;
  }

  private routerPostsNew(): void {
    this.$router.push('/posts/new').catch((e) => {});
    this.$router.go(0);
  }

  private reload(): void {
    this.$router.go(0);
  }

  private created(): void {
    this.getPosts();
  }

  private get filteredPosts(): Array<PostsData> {
    let posts = [];
    for(let i in this.postsData) {
      let post = this.postsData[i];
      if(post.title.indexOf(this.keyword) !== -1 || post.genre.indexOf(this.keyword) !== -1) {
        posts.push(post);
      }
    }
    return posts;
  }

  // 以下ページネーション機能の修正までコメントアウト
  // private pageChange(page): void {
  //   this.displayPosts = this.postsData.slice(this.pageSize*(page -1), this.pageSize*(page));
  // },
}
</script>

<style lang="scss" scoped>
  .posts-new-btn {
    height: 80px;
    width: 80px;
    background-color: #c1c1ff;
    opacity: 0.9;
    z-index: 10;
  }

  .posts-search-form {
    position: sticky;
    top: 80px;
    z-index: 1;
  }
</style>