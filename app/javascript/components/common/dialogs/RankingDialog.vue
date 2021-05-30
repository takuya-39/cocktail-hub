<template>
  <v-card
    color="#d1c4e9"
    tile
  >
    <v-container class="p-3">
      <v-toolbar
        color="#d1c4e9"
        dark
        flat
      >
        <!-- いいねランキングダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
          いいねランキング
        </v-card-title>
        <!-- 空白 -->
        <v-spacer></v-spacer>
        <!-- 閉じるボタン -->
        <v-tooltip bottom>
          <template #activator="{ on, attrs }">
            <v-btn
              class="mt-5 mr-3"
              icon
              v-bind="attrs"
              v-on="on"
              @click="switchRanking()"
            >
              <v-icon
                color="white"
                size="50px"
              >
                mdi-close
              </v-icon>
            </v-btn>
          </template>
          <span>閉じる</span>
        </v-tooltip>
      </v-toolbar>
      <v-container class="mt-5">
        <v-row class="justify-content-center">
          <v-col
            v-for="(post, index) in postsData"
            :key="post.id"
            cols=10
          >
            <v-col
              cols=10
              class="d-flex mt-3"
            >
              <!-- ランキング1位のアイコン -->
              <v-icon
                class="mdi-36px mr-5"
                color="#e6b422"
                v-if="index === 0"
              >
                mdi-podium-gold
              </v-icon>
              <!-- ランキング2位のアイコン -->
              <v-icon
                class="mdi-36px mr-5"
                color="#c0c0c0"
                v-if="index === 1"
              >
                mdi-podium-silver
              </v-icon>
              <!-- ランキング3位のアイコン -->
              <v-icon
                class="mdi-36px mr-5"
                color="#b87333"
                v-if="index === 2"
              >
                mdi-podium-bronze
              </v-icon>
              <!-- 順位 -->
              <h3 class="text-bold text-monospace text-light mt-3 mr-10">
                {{ index + 1 }}位
              </h3>
              <!-- いいね数 -->
              <h3 class="text-bold text-monospace text-dark mt-3">
                {{ post.likes.length }}
              </h3>
              <h5 class="text-light align-self-end">
                いいね
              </h5>
            </v-col>
            <!-- 投稿カード -->
            <v-card
              :class="[`post-${ post.id }`, `index-${ index }`]"
              @click="screenTransition(path = `/posts/${ post.id }`), switchRanking()"
            >
              <v-img
                class="align-end"
                height="250px"
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

<script lang="ts">
import { Component, Vue, Prop, Emit } from 'vue-property-decorator';
import axios from 'axios';
import { PostsData } from '@/types/@types/LibraryComponent';

@Component({
  components: {}
})

export default class RankingDialog extends Vue {
  @Prop(Boolean) public dialogRanking!: Boolean;

  @Emit('switchRanking')
  private switchRanking(): void {
    this.dialogRanking = !this.dialogRanking;
  }

  private postsData: Array<PostsData> = [];

  private getPosts(): void {
    axios
      .get('/api/v1/rankings/')
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
}
</script>

<style lang="scss" scoped>
</style>