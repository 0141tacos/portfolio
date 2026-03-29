<script setup>
import MENU_CONST from "./constants/const.js";
import Career from "./components/Career.vue";
import Feature from "./components/Feature.vue";
import Menu from "./components/Menu.vue";
</script>

<template>
  <div class="max-w-8/10 m-8 p-4">
    <div class="flex">
      <div class="w-25 flex-auto m-5">
        <div><h1 class="">Hirotaka Sato</h1></div>
        <div><h2>Fullstack Engineer</h2></div>
        <div>
          <p>
            Full-stack engineer building web applications with Python and
            JavaScript.<br />
            Interested in software architecture and cloud infrastructure.<br />
            Nice to meet you!<br />
          </p>
        </div>
        <Menu></Menu>
      </div>
      <div class="w-70 flex-auto m-5" id="">
        <div class="row">
          <div :id="MENU_CONST.ABOUT">
            <Career></Career>
            <Feature></Feature>
          </div>
          <div :id="MENU_CONST.CONTACT">
            <h3>Contact</h3>
            <p>hogehoge@gmail.com</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
#self-introduction {
  margin-left: 40%;
  margin-top: 10%;
}
</style>
