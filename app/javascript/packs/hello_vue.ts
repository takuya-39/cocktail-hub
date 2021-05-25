import Vue from 'vue';
import App from '@/App.vue';
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import '@mdi/font/css/materialdesignicons.css';
import router from './router';

Vue.use(Vuetify, {});
const vuetify = new Vuetify({
  icon: {
    iconfont: "mdi"
  }
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})