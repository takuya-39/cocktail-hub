<template>
  <div class="loading loading-background">
    <div class="loading-container">
      <span></span>
      <span></span>
      <span></span>
      <h1 class="loading-message">LOADING...</h1>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
  components: {}
})

export default class Loading extends Vue {
  private mounted(): void {
    window.onload = function() {
      const load = document.getElementsByClassName('loading');
      load[0].classList.add('loaded');
    }
  }
}
</script>

<style lang="sass" scoped>
.loading-background{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  font-family: 'ヒラギノ角ゴシック';
  font-weight: bold;
  z-index: 1000;
  background-color: #222222;
  opacity: .9;
}

.loading-container span{
  position: fiexd;
  display: block;
  background-color: #d1c4e9;
  width: 150px;
  height: 10px;
  animation: load 2s infinite;
  border-radius: 10px;
}

.loading-container {
  position: fixed;
  top: calc( 50% - 100px );
  left: calc( 50% - 100px );
}

.loading-container span:nth-child(2){
  animation-delay: 100ms;
}

.loading-container span:nth-child(3){
  animation-delay: 200ms;
}

.loading-message {
  color: #d1c4e9;
  margin-top: 15px;
}

.loaded {
  opacity: 0;
  visibility: hidden;
}

@keyframes load{
  50%{
    width: 5px;
    margin-right: 95px;
    opacity: .1;
  }
}
</style>