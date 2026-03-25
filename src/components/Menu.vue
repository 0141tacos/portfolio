<script setup>
import MENU_CONST from "../constants/const.js";
/* ◯ホバーしたときに表示を変える用
import { ref } from "vue";

const isHover = ref(false);

function mouseEnter() {
  isHover.value = true;
}

function mouseLeave() {
  isHover.value = false;
}
*/

function scrollToTarget(id) {
  if (id === "top") {
    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  } else {
    const target = document.getElementById(id);
    target.scrollIntoView({
      behavior: "smooth",
    });
  }
}
</script>
<template>
  <div class="cursor-pointer">
    <ul class="list-unstyled">
      <li class="p-1">
        <!-- ◯ホバーしたときに表示を変える用
        <span
          class="d-inline"
          role="button"
          @mouseenter="mouseEnter"
          @mouseleave="mouseLeave"
          @click="scrollToTarget(MENU_CONST.TOP)"
        >
          {{ isHover ? "--Top" : "Top" }}
        </span>
        -->
        <span
          class="d-inline"
          role="button"
          @click="scrollToTarget(MENU_CONST.TOP)"
        >
          Top
        </span>
      </li>
      <li class="p-1">
        <span
          class="d-inline"
          role="button"
          @click="scrollToTarget(MENU_CONST.ABOUT)"
        >
          About
        </span>
      </li>
      <li class="p-1">
        <span
          class="d-inline"
          role="button"
          @click="scrollToTarget(MENU_CONST.CONTACT)"
        >
          Contact
        </span>
      </li>
    </ul>
  </div>
</template>
<style>
li span:hover {
  color: var(--bs-white);
  font-weight: bold;
}
</style>
