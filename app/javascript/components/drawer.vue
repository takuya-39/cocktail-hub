<template>

  <!-- ドロワーリスト -->
  <v-list nav>
    <v-list-item-group
      active-class="deep-purple--text text--accent-4"
      v-model="userData"
    >

      <!-- ドロワーアイテム【Hubに戻る】 -->
      <v-list-item
        class='go-root'
        v-if="this.$route.path !== '/'"
        @click="$router.push('/').catch(e=>{}), $emit('reload')"
      >
        <v-list-item-icon>
          <v-icon class="mdi-36px">
            mdi-home-import-outline
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>Hubに戻る</v-list-item-title>
      </v-list-item>

      <v-list-item-group v-if="loggedInUser">
        <!-- ドロワーアイテム【マイプロフィール】 -->
        <v-list-item
          class='users-show'
          v-if="this.$route.path !== `/users/${user.id}`"
          @click="$router.push(`/users/${user.id}`).catch(e=>{}), $emit('reload')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
              mdi-account-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>マイプロフィール</v-list-item-title>
        </v-list-item>

        <!-- ドロワーアイテム【ユーザーを編集する】 -->
        <v-list-item
          class='users-edit'
          v-if="this.$route.path !== '/users/edit'"
          @click="$router.push('/users/edit').catch(e=>{}), $emit('reload')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
              mdi-account-cog-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>ユーザーを編集する</v-list-item-title>
        </v-list-item>

        <!-- 区切りライン -->
        <v-divider></v-divider>

      </v-list-item-group>

      <v-list-item-group v-else>
        <!-- ドロワーアイテム【ユーザーを作成する】 -->
        <v-list-item
          class='signup'
          @click="$router.push('/signup').catch(e=>{}), $emit('reload')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
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
          @click="$emit('switchDrawer'), $emit('switchRanking')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
              mdi-crown-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>いいねランキング</v-list-item-title>
        </v-list-item>

        <!-- ドロワーアイテム【ランダム】 -->
        <v-list-item
          class="drawer-random"
          @click="$emit('switchDrawer'), $emit('switchRandom')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
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
        @click="$emit('switchDrawer'), $emit('switchExplanation')"
      >
        <v-list-item-icon>
          <v-icon class="mdi-36px">
            mdi-glass-cocktail
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>Cooktail Hubとは？</v-list-item-title>
      </v-list-item>

      <v-list-item-group v-if="loggedInUser">
        <!-- ドロワーアイテム【ログアウト】 -->
        <v-list-item
          class='logout'
          @click="$router.push('/logout').catch(e=>{}), $emit('reload')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
              mdi-alpha-l-circle
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>ログアウト</v-list-item-title>
        </v-list-item>
      </v-list-item-group>

      <v-list-item-group v-else>
        <!-- ドロワーアイテム【ログイン】 -->
        <v-list-item
          class='login'
          @click="$router.push('/login').catch(e=>{}), $emit('reload')"
        >
          <v-list-item-icon>
            <v-icon class="mdi-36px">
              mdi-alpha-l-circle-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>ログイン</v-list-item-title>
        </v-list-item>
      </v-list-item-group>
    </v-list-item-group>
  </v-list>
</template>

<script>

import axios from 'axios'

export default {
  data: function () {
    return {
      user: [],
      loggedInUser: [],
    }
  },
  created() {
    axios.get('/api/v1/users')
      .then(res => {
        this.user = res.data
        this.loggedInUser = this.user
      })
  },
}
</script>

<style scoped>
</style>