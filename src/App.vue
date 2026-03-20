<script setup>
import Career from "./components/Career.vue";
import Feature from "./components/Feature.vue";
</script>

<template>
  <div class="container">
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
    <div class="row">
      <Career></Career>
      <Feature></Feature>
    </div>
  </div>
</template>

<style scoped></style>
