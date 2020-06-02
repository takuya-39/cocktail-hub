import Vue from 'vue'
import VueRouter from 'vue-router';
// import PostsIndex from 'posts/index.vue'

Vue.use(VueRouter);

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: PostsIndex, name: 'root_path' },
  ],
})