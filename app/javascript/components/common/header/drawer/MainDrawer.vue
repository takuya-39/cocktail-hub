<template>
  <div>
    <!-- スマホでない場合 -->
    <div v-if="!judgmentMobile">
      <!-- ドロワーリスト -->
      <v-list nav>
        <v-list-item-group
          active-class="deep-purple--text text--accent-4"
        >
          <!-- ドロワーアイテム【ドロワーを閉じる】 -->
          <v-list-item
            class="close-drawer"
            @click="switchDrawer()"
          >
            <v-list-item-icon>
              <v-icon
                :size="defaultDrawerIconSize"
              >
                mdi-arrow-collapse-left
              </v-icon>
            </v-list-item-icon>
            <v-list-item-title>ドロワーを閉じる</v-list-item-title>
          </v-list-item>
          <!-- ドロワーアイテム【Hubに戻る】 -->
          <v-list-item
            class="go-root"
            v-if="this.$route.path !== '/'"
            @click="screenTransition(path = '/')"
          >
            <v-list-item-icon>
              <v-icon
                :size="defaultDrawerIconSize"
              >
                mdi-home-import-outline
              </v-icon>
            </v-list-item-icon>
            <v-list-item-title>Hubに戻る</v-list-item-title>
          </v-list-item>
          <v-list-item-group v-if="loggedInUser">
            <!-- ドロワーアイテム【マイプロフィール】 -->
            <v-list-item
              class="users-show"
              v-if="this.$route.path !== `/users/${ userId }`"
              @click="screenTransition(path = `/users/${ userId }`)"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-account-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>マイプロフィール</v-list-item-title>
            </v-list-item>
            <!-- ドロワーアイテム【ユーザーを編集する】 -->
            <v-list-item
              class="users-edit"
              v-if="this.$route.path !== '/users/edit'"
              @click="screenTransition(path = '/users/edit')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-account-cog-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>ユーザーを編集する</v-list-item-title>
            </v-list-item>
            <!-- 区切りライン -->
            <v-divider></v-divider>
          </v-list-item-group>
          <v-list-item-group v-if="!loggedInUser">
            <!-- ドロワーアイテム【ユーザーを作成する】 -->
            <v-list-item
              class="signup"
              @click="screenTransition(path = '/signup')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-account-plus-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>ユーザーを作成する</v-list-item-title>
            </v-list-item>
            <!-- 区切りライン -->
            <v-divider></v-divider>
          </v-list-item-group>
          <!-- 投稿一覧ページでのみ表示するドロワーメニュー -->
          <v-list-item-group v-if="this.$route.path === '/'">
            <!-- ドロワーアイテム【いいねランキング】 -->
            <v-list-item
              class="drawer-ranking"
              @click="switchDrawer(), switchRanking()"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-crown-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>いいねランキング</v-list-item-title>
            </v-list-item>
            <!-- ドロワーアイテム【ランダム】 -->
            <v-list-item
              class="drawer-random"
              @click="switchDrawer(), switchRandom()"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-dice-5-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>ランダム</v-list-item-title>
            </v-list-item>
            <!-- 区切りライン -->
            <v-divider></v-divider>
          </v-list-item-group>
          <!-- ドロワーアイテム【Cooktail Hubとは？】 -->
          <v-list-item
            class="drawer-explanation"
            @click="switchDrawer(), switchExplanation()"
          >
            <v-list-item-icon>
              <v-icon
                :size="defaultDrawerIconSize"
              >
                mdi-glass-cocktail
              </v-icon>
            </v-list-item-icon>
            <v-list-item-title>Cooktail Hubとは？</v-list-item-title>
          </v-list-item>
          <v-list-item-group v-if="loggedInUser">
            <!-- ドロワーアイテム【ログアウト】 -->
            <v-list-item
              class="logout"
              @click="screenTransition(path = '/logout')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-alpha-l-circle
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>ログアウト</v-list-item-title>
            </v-list-item>
          </v-list-item-group>
          <v-list-item-group v-if="!loggedInUser">
            <!-- ドロワーアイテム【ログイン】 -->
            <v-list-item
              class="login"
              @click="screenTransition(path = '/login')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="defaultDrawerIconSize"
                >
                  mdi-alpha-l-circle-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title>ログイン</v-list-item-title>
            </v-list-item>
          </v-list-item-group>
        </v-list-item-group>
      </v-list>
    </div>

    <!-- スマホの場合 -->
    <div v-if="judgmentMobile">
      <!-- ドロワーリスト -->
      <v-list nav>
        <v-list-item-group
          active-class="deep-purple--text text--accent-4"
        >
          <!-- ドロワーアイテム【ドロワーを閉じる】 -->
          <v-list-item
            class="close-drawer"
            @click="switchDrawer()"
          >
            <v-list-item-icon>
              <v-icon
                :size="mobileDrawerIconSize"
              >
                mdi-arrow-collapse-left
              </v-icon>
            </v-list-item-icon>
            <v-list-item-title class="list-item-title">ドロワーを閉じる</v-list-item-title>
          </v-list-item>
          <!-- ドロワーアイテム【Hubに戻る】 -->
          <v-list-item
            class="go-root"
            v-if="this.$route.path !== '/'"
            @click="screenTransition(path = '/')"
          >
            <v-list-item-icon>
              <v-icon
                :size="mobileDrawerIconSize"
              >
                mdi-home-import-outline
              </v-icon>
            </v-list-item-icon>
            <v-list-item-title class="list-item-title">Hubに戻る</v-list-item-title>
          </v-list-item>
          <v-list-item-group v-if="loggedInUser">
            <!-- ドロワーアイテム【マイプロフィール】 -->
            <v-list-item
              class="users-show"
              v-if="this.$route.path !== `/users/${ userId }`"
              @click="screenTransition(path = `/users/${ userId }`)"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-account-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">マイプロフィール</v-list-item-title>
            </v-list-item>
            <!-- ドロワーアイテム【ユーザーを編集する】 -->
            <v-list-item
              class="users-edit"
              v-if="this.$route.path !== '/users/edit'"
              @click="screenTransition(path = '/users/edit')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-account-cog-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">ユーザーを編集する</v-list-item-title>
            </v-list-item>
            <!-- 区切りライン -->
            <v-divider></v-divider>
          </v-list-item-group>
          <v-list-item-group v-if="!loggedInUser">
            <!-- ドロワーアイテム【ユーザーを作成する】 -->
            <v-list-item
              class="signup"
              @click="screenTransition(path = '/signup')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-account-plus-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">ユーザーを作成する</v-list-item-title>
            </v-list-item>
            <!-- 区切りライン -->
            <v-divider></v-divider>
          </v-list-item-group>
          <!-- 投稿一覧ページでのみ表示するドロワーメニュー -->
          <v-list-item-group v-if="this.$route.path === '/'">
            <!-- ドロワーアイテム【いいねランキング】 -->
            <v-list-item
              class="drawer-ranking"
              @click="switchDrawer(), switchRanking()"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-crown-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">いいねランキング</v-list-item-title>
            </v-list-item>
            <!-- ドロワーアイテム【ランダム】 -->
            <v-list-item
              class="drawer-random"
              @click="switchDrawer(), switchRandom()"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-dice-5-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">ランダム</v-list-item-title>
            </v-list-item>
            <!-- 区切りライン -->
            <v-divider></v-divider>
          </v-list-item-group>
          <!-- ドロワーアイテム【Cooktail Hubとは？】 -->
          <v-list-item
            class="drawer-explanation"
            @click="switchDrawer(), switchExplanation()"
          >
            <v-list-item-icon>
              <v-icon
                :size="mobileDrawerIconSize"
              >
                mdi-glass-cocktail
              </v-icon>
            </v-list-item-icon>
            <v-list-item-title class="list-item-title">Cooktail Hubとは？</v-list-item-title>
          </v-list-item>
          <v-list-item-group v-if="loggedInUser">
            <!-- ドロワーアイテム【ログアウト】 -->
            <v-list-item
              class="logout"
              @click="screenTransition(path = '/logout')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-alpha-l-circle
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">ログアウト</v-list-item-title>
            </v-list-item>
          </v-list-item-group>
          <v-list-item-group v-if="!loggedInUser">
            <!-- ドロワーアイテム【ログイン】 -->
            <v-list-item
              class="login"
              @click="screenTransition(path = '/login')"
            >
              <v-list-item-icon>
                <v-icon
                  :size="mobileDrawerIconSize"
                >
                  mdi-alpha-l-circle-outline
                </v-icon>
              </v-list-item-icon>
              <v-list-item-title class="list-item-title">ログイン</v-list-item-title>
            </v-list-item>
          </v-list-item-group>
        </v-list-item-group>
      </v-list>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Emit, Model } from 'vue-property-decorator';
import axios from 'axios';
import isMobile from 'ismobilejs';
import { LoggedInUser } from '@/types/@types/LibraryComponent';

@Component({
  components: {}
})

export default class MainDrawer extends Vue {
  @Model('change', {type: Boolean}) public menuDrawer!: Boolean;

  @Prop(Boolean) public dialogExplanation!: Boolean;
  @Prop(Boolean) public dialogRanking!: Boolean;
  @Prop(Boolean) public dialogRandom!: Boolean;

  @Emit('switchDrawer')
  private switchDrawer(): void {
    this.menuDrawer = !this.menuDrawer;
  }

  @Emit('switchExplanation')
  private switchExplanation(): void {
    this.dialogExplanation = !this.dialogExplanation;
  }

  @Emit('switchRanking')
  private switchRanking(): void {
    this.dialogRanking = !this.dialogRanking;
  }

  @Emit('switchRandom')
  private switchRandom(): void {
    this.dialogRandom = !this.dialogRandom;
  }

  private defaultDrawerIconSize: string = '36px';
  private mobileDrawerIconSize: string = '100px';
  private judgmentMobile: boolean = isMobile().phone;
  private userId: number = 0;
  private loggedInUser: LoggedInUser = {
    id: 0,
    username: '',
    profile: '',
    email: '',
    created_at: '',
    updated_at: '',
    admin: false
  };

  private screenTransition(path: string): void {
    this.$router.push(path).catch(e=>{});
    this.$router.go(0);
  }

  private getUser(): void {
    axios
      .get('/api/v1/users')
      .then(res => {
        this.loggedInUser = res.data;
        this.userId = res.data.id;
      })
      return;
  }

  private created(): void {
    this.getUser();
  }
}
</script>

<style lang="scss" scoped>
.list-item-title {
  font-size: 30px;
}
</style>