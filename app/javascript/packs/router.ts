// import Vue from 'vue'
// import VueRouter from 'vue-router';
// import PostsIndex from 'posts/index.vue'

// Vue.use(VueRouter);

// export default new VueRouter({
//   mode: 'history',
//   routes: [
//     { path: '/', component: PostsIndex, name: 'root_path' },
//   ],
// })


// import Vue from 'vue'
// import VueRouter from 'vue-router';

// const PostsIndex = () => import('/posts/index.vue');

// Vue.use(VueRouter);

// let routes: Array<any> = [
//   {
//     path: '/',
//     name: 'PostIndex',
//     component: PostsIndex,
//     meta: {
//       title: '投稿一覧',
//       isPublic: false,
//       KeepAlive: true,
//       isAuthority: '',
//     },
//   }
// ]

// const router = new VueRouter({
//   routes,
// });

// export default router;



import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'
import PostsIndex from '@/components/posts/index.vue'

Vue.use(VueRouter)

  const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: 'PostIndex',
    component: PostsIndex
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router