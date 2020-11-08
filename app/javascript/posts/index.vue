<template>
  <v-app id="app">

    <!-- コンテンツ全体 -->
    <v-card color="#060211" tile>
      <v-container fluid class="mx-auto" max-width="100%" id="go-top">
        <v-row dense>
          <v-col
            v-for="post in displayPosts"
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
      page: 1,
      pageSize: 10,
      length:0,
    };
  },
  created() {
    axios.get('/api/v1/posts')
      .then(res => {
        this.posts = res.data
        this.length = Math.ceil(this.posts.length/this.pageSize);
        this.displayPosts = this.posts.slice(this.pageSize*(this.page -1), this.pageSize*(this.page));
      })
  },
  methods: {
    pageChange: function(pageNumber){
      this.displayPosts = this.posts.slice(this.pageSize*(pageNumber -1), this.pageSize*(pageNumber));
    },
    reload() {
      this.$router.go({path: this.$router.currentRoute.path, force: true});
    },
  },
}
</script>

<style scoped>
</style>