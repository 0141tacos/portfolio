<script setup>
import MENU_CONST from '../constants/const.js';

function scrollToTarget(id) {
  if (id === 'top') {
    window.scrollTo({
      top: 0,
      behavior: 'smooth',
    });
  } else {
    const target = document.getElementById(id);
    target.scrollIntoView({
      behavior: 'smooth',
    });
  }
}
</script>

<template>
  <div id="menu" class="m-1">
    <ul class="list-none">
      <li class="m-1">
        <router-link to="/" class="text-md font-bold">Home</router-link>
        <ul class="list-none">
          <li class="m-1">
            <span
              class="inline cursor-pointer hover:font-bold"
              @click="scrollToTarget(MENU_CONST.TOP)"
            >
              Top
            </span>
          </li>
          <li class="m-1">
            <span
              class="inline cursor-pointer hover:font-bold"
              @click="scrollToTarget(MENU_CONST.ABOUT)"
            >
              About
            </span>
          </li>
          <li class="m-1">
            <span
              class="inline cursor-pointer hover:font-bold"
              @click="scrollToTarget(MENU_CONST.CONTACT)"
            >
              Contact
            </span>
          </li>
        </ul>
      </li>
      <li class="m-1">
        <router-link to="/blog" class="text-md font-bold">Blog</router-link>
      </li>
    </ul>
  </div>
</template>

<style></style>
