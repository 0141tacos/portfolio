<script setup>
import Blog from '@/components/BlogContent.vue';
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <h3 class="text-2xl">Blog</h3>
    <div id="blog" class="m-1">
      <article class="border-2 rounded-2xl p-3 m-1">
        <h4>title</h4>
        <p>testcontent</p>
        <span class="tag-test">test</span>
        <span class="mx-1 tag-test2">test2</span>
      </article>
      <article class="border-2 rounded-2xl p-3 m-1">
        <h4>title</h4>
        <p>testcontent</p>
      </article>
    </div>
  </div>
</template>

<style scoped></style>
