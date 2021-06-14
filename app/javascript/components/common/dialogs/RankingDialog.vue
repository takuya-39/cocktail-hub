<template>
  <v-card
    tile
    :color="rankingDialogColor"
  >
    <v-container class="p-3">
      <v-toolbar
        dark
        flat
        :color="rankingDialogColor"
      >
        <!-- いいねランキングダイアログのタイトル -->
        <v-card-title class="display-1 font-weight-bold mt-15 ml-3">
          いいねランキング
        </v-card-title>
        <!-- 空白 -->
        <v-spacer></v-spacer>
        <!-- スマートフォンでない場合 -->
        <div v-if="!judgmentMobile">
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
                  :color="defaultCloseButtonColor"
                  :size="defaultCloseButtonSize"
                >
                  mdi-close
                </v-icon>
              </v-btn>
            </template>
            <span>閉じる</span>
          </v-tooltip>
        </div>
        <!-- スマートフォンの場合 -->
        <div v-if="judgmentMobile">
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
                  :color="mobileCloseButtonColor"
                  :size="mobileCloseButtonSize"
                >
                  mdi-close
                </v-icon>
              </v-btn>
            </template>
            <span>閉じる</span>
          </v-tooltip>
        </div>
      </v-toolbar>
      <v-container class="mt-5">
        <v-row class="justify-content-center">
          <v-col
            v-for="(post, index) in postsData"
            :key="post.id"
            cols="10"
          >
            <v-col
              cols="10"
              class="d-flex mt-3"
            >
              <!-- ランキング1位のアイコン -->
              <v-icon
                class="mr-5"
                :color="firstPlaceColor"
                :size="firstPlaceSize"
                v-if="index === 0"
              >
                mdi-podium-gold
              </v-icon>
              <!-- ランキング2位のアイコン -->
              <v-icon
                class="mr-5"
                :color="secondPlaceColor"
                :size="secondPlaceSize"
                v-if="index === 1"
              >
                mdi-podium-silver
              </v-icon>
              <!-- ランキング3位のアイコン -->
              <v-icon
                class="mr-5"
                :color="thirdPlaceColor"
                :size="thirdPlaceSize"
                v-if="index === 2"
              >
                mdi-podium-bronze
              </v-icon>
              <!-- 順位 -->
              <h1 class="text-light mt-5 mr-10">
                {{ index + 1 }}位
              </h1>
              <!-- いいね数 -->
              <h1 class="mr-2 like-count">
                {{ post.likes.length }}
              </h1>
              <h4 class="text-light align-self-end">
                いいね
              </h4>
            </v-col>
            <!-- 投稿カード -->
            <v-card
              class="ranking-card reflection"
              :class="[`post-${ post.id }`, `index-${ index }`]"
              @click="screenTransition(path = `/posts/${ post.id }`), switchRanking()"
            >
              <v-img
                class="align-end"
                :height="rankingImageHeight"
                :gradient="rankingImageGradient"
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
import isMobile from 'ismobilejs';
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

  private rankingDialogColor: string = '#d1c4e9';
  private defaultCloseButtonColor: string = '#ffffff';
  private defaultCloseButtonSize: string = '50px';
  private mobileCloseButtonColor: string = '#ffffff';
  private mobileCloseButtonSize: string = '100px';
  private firstPlaceColor: string = '#e6b422';
  private firstPlaceSize: string = '50px';
  private secondPlaceColor: string = '#c0c0c0';
  private secondPlaceSize: string = '50px';
  private thirdPlaceColor: string = '#b87333';
  private thirdPlaceSize: string = '50px';
  private rankingImageHeight: string = '350px';
  private rankingImageGradient: string = 'to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)';
  private judgmentMobile: boolean = isMobile().phone;
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
.like-count {
  font-size: 60px;
  color: #5e5977;
}

.ranking-card {
  display: inline-block;
  transition-duration: .8s;
  transition-property: box-shadow;
  &:hover {
    box-shadow: 0 5px 20px rgba(6, 2, 18, .7) !important;
  }
}

.reflection {
  overflow: hidden;
}

.reflection::after {
  content: "";
  width: 30px;
  height: 100%;
  position: absolute;
  top: -180px;
  left: 0;
  background-color: #ffffff;
  opacity: 0;
  transform: rotate(45deg);
  animation: reflect 5s ease-in-out infinite;
  -webkit-transform: rotate(45deg);
  -webkit-animation: reflect 4s ease-in-out infinite;
}

@keyframes reflect {
  0% { transform: scale(0) rotate(45deg); opacity: 0; }
  80% { transform: scale(0) rotate(45deg); opacity: 0.5; }
  81% { transform: scale(4) rotate(45deg); opacity: 1; }
  100% { transform: scale(50) rotate(45deg); opacity: 0; }
}
@-webkit-keyframes reflect {
  0% { transform: scale(0) rotate(45deg); opacity: 0; }
  80% { transform: scale(0) rotate(45deg); opacity: 0.5; }
  81% { transform: scale(4) rotate(45deg); opacity: 1; }
  100% { transform: scale(50) rotate(45deg); opacity: 0; }
}
</style>