<template>

  <!-- ドロワーリスト -->
  <v-list nav>
    <v-list-item-group
      v-model="group"
      active-class="deep-purple--text text--accent-4"
    >

      <!-- ドロワーアイテム【Hubに戻る】 -->
      <!-- rootページにつながる -->
      <!-- root以外のページ -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-home-import-outline</v-icon>
        </v-list-item-icon>
        <v-list-item-title>Hubに戻る</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【ユーザープロフィール】 -->
      <!-- ユーザープロフィールにつながる -->
      <!-- (ログイン後) root -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-account-outline</v-icon>
        </v-list-item-icon>
        <v-list-item-title>ユーザープロフィール</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【ユーザーを作成する】 -->
      <!-- ユーザー作成ページにつながる -->
      <!-- 別ページ実装かダイアログかで仕様変わる -->
      <!-- (ログイン前) root -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-account-plus-outline</v-icon>
          <!-- <v-icon class="mdi-36px">mdi-account-cog-outline</v-icon> -->
        </v-list-item-icon>
        <v-list-item-title>ユーザーを作成する</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【ユーザーを編集する】 -->
      <!-- ユーザー編集ページにつながる -->
      <!-- 別ページ実装かダイアログかで仕様変わる -->
      <!-- (ログイン後) users/show -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-account-cog-outline</v-icon>
          <!-- <v-icon class="mdi-36px">mdi-account-cog-outline</v-icon> -->
        </v-list-item-icon>
        <v-list-item-title>ユーザーを編集する</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【投稿を編集する】 -->
      <!-- 投稿編集ページにつながる -->
      <!-- (ログイン後) posts/show -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-file-cog-outline</v-icon>
          <!-- <v-icon class="mdi-36px">mdi-account-cog-outline</v-icon> -->
        </v-list-item-icon>
        <v-list-item-title>投稿を編集する</v-list-item-title>
      </v-list-item>

      <!-- 区切りライン -->
      <v-divider></v-divider>

      <!-- ドロワーアイテム【いいねランキング】 -->
      <!-- ダイアログ -->
      <!-- root -->
      <v-list-item @click="$emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-crown-outline</v-icon>
          <!-- <v-icon class="mdi-36px">mdi-medal-outline</v-icon> -->
        </v-list-item-icon>
        <v-list-item-title>いいねランキング</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【ランダム】 -->
      <!-- ダイアログ -->
      <!-- root -->
      <v-list-item @click="$emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-dice-5-outline</v-icon>
        </v-list-item-icon>
        <v-list-item-title>ランダム</v-list-item-title>
      </v-list-item>

      <!-- 区切りライン -->
      <v-divider></v-divider>

      <!-- ドロワーアイテム【Cooktail Hubとは？】 -->
      <!-- ダイアログ -->
      <!-- 全てのページ -->
      <v-list-item
        @click="$emit('switchDrawer'), $emit('switchExplanation')"
      >
        <v-list-item-icon>
          <v-icon class="mdi-36px">
            mdi-glass-cocktail
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>Cooktail Hubとは？</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【ログイン】 -->
      <!-- ダイアログ -->
      <!-- (ログイン前) root -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-alpha-l-circle-outline</v-icon>
        </v-list-item-icon>
        <v-list-item-title>ログイン</v-list-item-title>
      </v-list-item>

      <!-- ドロワーアイテム【ログアウト】 -->
      <!-- ダイアログ -->
      <!-- (ログイン後) 全てのページ -->
      <v-list-item @click="$router.push('/').catch(e=>{}), $emit('switchDrawer')">
        <v-list-item-icon>
          <v-icon class="mdi-36px">mdi-alpha-l-circle</v-icon>
        </v-list-item-icon>
        <v-list-item-title>ログアウト</v-list-item-title>
      </v-list-item>
    </v-list-item-group>
  </v-list>
</template>

<script>
export default {
  data: function () {
    return {
    }
  },
}
</script>

<style scoped>
</style>