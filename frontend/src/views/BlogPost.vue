<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const goToBlog = () => {
  router.push('/blog');
};
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <div class="flex flex-col">
      <h3>Blog Post</h3>
      <h4>Title</h4>
      <input />
      <h4>Tag</h4>
      <input />
      <h4>Sub Tag</h4>
      <input />
      <h4>Contents</h4>
      <textarea />
    </div>
    <div class="flex flex-row justify-end">
      <button class="font-thin" @click="goToBlog">Back</button>
      <button>Post</button>
    </div>
  </div>
</template>

<style scoped></style>
