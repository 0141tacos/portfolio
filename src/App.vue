<script setup>
import MENU_CONST from "./constants/const.js";
import Career from "./components/Career.vue";
import Feature from "./components/Feature.vue";
import Menu from "./components/Menu.vue";
</script>

<template>
  <div class="max-w-9/10 mx-auto m-5">
    <div class="flex flex-col md:flex-row">
      <div class="flex-[1] m-5 p-2">
        <div><h1 class="text-3xl">Hirotaka Sato</h1></div>
        <div><h2 class="text-lg font-semibold">Fullstack Engineer</h2></div>
        <div>
          <p class="font-normal">
            Full-stack engineer building web applications with Python and
            JavaScript.<br />
            Interested in software architecture and cloud infrastructure.<br />
            Nice to meet you!<br />
          </p>
        </div>
        <Menu></Menu>
      </div>
      <div class="flex-[2] m-5 p-2" id="">
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
