<template>
  <v-app id="app">

    <!-- コンテンツ全体 -->
    <v-card color="#060211" tile>
      <v-container fluid class="mx-auto" max-width="100%" id="go-top">
        <v-row dense>
          <v-col
            v-for="post in posts"
            :key="post.id"
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
    };
  },
  created() {
    axios.get('/api/v1/posts')
      .then(res => {
        this.posts = res.data
      })
  },
  methods: {
    reload() {
      this.$router.go({path: this.$router.currentRoute.path, force: true});
    },
  },
}
</script>

<style scoped>
</style>