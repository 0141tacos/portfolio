<script setup>
import MENU_CONST from "./constants/const.js";
import Career from "./components/Career.vue";
import Feature from "./components/Feature.vue";
import Menu from "./components/Menu.vue";
</script>

<template>
  <div class="container">
    <div class="d-flex">
      <div class="position-fixed top-50 translate-middle-y w-25">
        <div><h1>Hirotaka Sato</h1></div>
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
      <div class="w-75" id="self-introduction">
        <div class="row">
          <div :id="MENU_CONST.ABOUT">
            <Career></Career>
            <Feature></Feature>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
            <h1>a</h1>
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
