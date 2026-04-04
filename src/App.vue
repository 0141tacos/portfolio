<script setup>
import MENU_CONST from "./constants/const.js";
import Career from "./components/Career.vue";
import Feature from "./components/Feature.vue";
import Menu from "./components/Menu.vue";
</script>

<template>
  <div class="container mx-auto m-5 min-w-xs">
    <div class="flex flex-col md:flex-row">
      <div class="flex-[2] p-5">
        <div><h1 class="text-3xl m-1">Hirotaka Sato</h1></div>
        <div><h2 class="text-lg font-semibold m-1">Fullstack Engineer</h2></div>
        <div class="m-1">
          <p class="font-light">
            Full-stack engineer building web applications with Python and
            JavaScript.<br />
            Interested in software architecture and cloud infrastructure.<br />
            Nice to meet you!<br />
          </p>
        </div>
        <Menu></Menu>
      </div>
      <div class="flex-[3] p-5" id="">
        <div class="">
          <div :id="MENU_CONST.ABOUT">
            <Career></Career>
            <Feature></Feature>
          </div>
          <div :id="MENU_CONST.CONTACT" class="m-1">
            <h3 class="text-2xl">Contact</h3>
            <div class="m-1">
              <p class="">hogehoge@gmail.com</p>
              <a
                href="https://x.com/baretaco_rundev"
                target="_blank"
                rel="noopener noreferrer"
                >X</a
              >
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
