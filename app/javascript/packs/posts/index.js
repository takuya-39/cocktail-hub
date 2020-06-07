import Vue from 'vue'
import PostsIndex from '../../posts/index.vue'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import '@mdi/font/css/materialdesignicons.css'
import router from '../router.js';


Vue.use(Vuetify, {});
const vuetify = new Vuetify({
  icons: {
    iconfont: 'mdi'
  },
});



document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    render: h => h(PostsIndex)
  }).$mount()
  document.body.appendChild(app.$el)
})