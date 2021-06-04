<template>
  <v-app id="app">
    <!-- コンテンツ全体 -->
    <v-card
      tile
      :color="postsIndexBackColor"
    >
      <v-container
        id="go-top"
        class="mx-auto"
        fluid
        :max-width="postsIndexMaxWidth"
      >
        <!-- 新規投稿アイコン -->
        <v-tooltip
          bottom
        >
          <template #activator="{ on, attrs }">
            <!-- スマホでない場合 -->
            <div v-show="!judgmentMobile">
              <v-btn
                class="post-new-btn default-post-new-btn"
                bottom
                fixed
                icon
                right
                v-bind="attrs"
                v-on="on"
                @click.stop="screenTransition(path = '/posts/new')"
              >
                <v-icon
                  :color="DefaultPostNewButtonColor"
                  :size="DefaultPostNewButtonSize"
                >
                  mdi-plus-circle-outline
                </v-icon>
              </v-btn>
            </div>
            <!-- スマホの場合 -->
            <div v-show="judgmentMobile">
              <v-btn
                class="post-new-btn mobile-post-new-btn"
                bottom
                fixed
                icon
                right
                v-bind="attrs"
                v-on="on"
                @click.stop="screenTransition(path = '/posts/new')"
              >
                <v-icon
                  :color="MobilePostNewButtonColor"
                  :size="MobilePostNewButtonSize"
                >
                  mdi-plus-circle-outline
                </v-icon>
              </v-btn>
            </div>
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
                <h4 class="mt-3 ml-5">
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
                      <v-icon
                        :color="closeButtonColor"
                        :size="closeButtonSize"
                      >
                        mdi-close
                      </v-icon>
                    </v-btn>
                  </template>
                  <span>閉じる</span>
                </v-tooltip>
              </v-col>
            </v-row>
            <!-- 投稿検索入力フォーム -->
            <v-text-field
              id="posts-search-form"
              class="pt-4"
              filled
              rounded
              :label="postsSearchFormLabel"
              v-model="keyword"
            >
            </v-text-field>
          </v-container>
        </v-form>
        <v-row dense>
          <v-col
            v-for="post in filteredPosts"
            :key="post.id"
            cols="12"
            sm="6"
            md="6"
            lg="4"
          >
            <!-- (それぞれの投稿カード) -->
            <v-card
              class="post-card"
              tile
              :class="[`post-${ post.id }`]"
              @click="screenTransition(path = `/posts/${ post.id }`)"
            >
              <!-- (投稿カードのイメージ) -->
              <v-img
                class="align-end"
                :src="post.image"
                :height="postImageHeight"
                :gradient="postImageGradient"
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
import isMobile from 'ismobilejs';
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

  private postsIndexBackColor: string = '#060211';
  private postsIndexMaxWidth: string = '100%';
  private DefaultPostNewButtonColor: string = '#FFFFFF';
  private DefaultPostNewButtonSize: string = '50px';
  private MobilePostNewButtonColor: string = '#FFFFFF';
  private MobilePostNewButtonSize: string = '200px';
  private closeButtonColor: string = '#FFFFFF';
  private closeButtonSize: string = '50px';
  private postImageHeight: string = '250px';
  private postImageGradient: string = 'to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)';
  private postsSearchFormLabel: string = 'タイトルやジャンルを入力してください';
  private judgmentMobile: boolean = isMobile().phone;
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

  private screenTransition(path: string): void {
    this.$router.push(path).catch(e=>{});
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
  .default-post-new-btn {
    position: fiexd;
    bottom: 100px;
    right: 100px;
    height: 50px;
    width: 50px;
    background-color: #c1c1ff;
    opacity: .5;
    z-index: 10;
    display: inline-block;
    transition-duration: 1s;
    transition-property: transform;
    &:hover {
      transform: scale(1.7);
      opacity: 1;
    }
  }

  .mobile-post-new-btn {
    position: fiexd;
    bottom: 200px;
    right: 100px;
    height: 200px;
    width: 200px;
    background-color: #c1c1ff;
    z-index: 10;
    display: inline-block;
    transition-duration: 1s;
    transition-property: transform;
  }

  .posts-search-form {
    position: sticky;
    top: 80px;
    z-index: 1;
  }

  .post-card {
    display: inline-block;
    transition-duration: .8s;
    transition-property: border-radius;
    &:hover {
      border-radius: 5em !important;
    }
  }
</style>