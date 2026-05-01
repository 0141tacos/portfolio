<script setup>
import Menu from './components/Menu.vue';
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <div class="flex flex-col md:flex-row min-h-screen">
      <div
        id=""
        class="flex-[2] px-5 md:sticky md:top-0 md:h-screen md:flex md:flex-col md:py-20"
      >
        <div><h1 class="text-3xl m-1">Hirotaka Sato</h1></div>
        <div>
          <h2 class="text-lg font-semibold m-1">Fullstack Engineer</h2>
        </div>
        <div class="m-1">
          <p class="font-thin">
            Full-stack engineer building web applications with Python and
            JavaScript.<br />
            Interested in software architecture and cloud infrastructure.<br />
            Nice to meet you!<br />
          </p>
        </div>
        <Menu></Menu>
      </div>
      <div class="flex-[3] px-5 md:py-20" id="">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
