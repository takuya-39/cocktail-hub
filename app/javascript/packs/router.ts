import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';
import PostsIndex from '@/components/posts/index.vue';

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