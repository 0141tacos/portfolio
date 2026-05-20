<script setup>
import { ref } from 'vue';
import Blog from '@/components/BlogContent.vue';

const blogs = ref({});

const fetchBlogs = async () => {
  const res = await fetch(`${import.meta.env.VITE_API_URL}/blogs`);
  blogs = await res.json();
};

fetchBlogs;
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <h3 class="text-2xl">Blog</h3>
    <div id="blog" class="m-1">
      <article
        class="border-2 rounded-2xl p-3 m-1"
        v-for="blog in blogs"
        :key="blog.id"
      >
        <h4>{{ blog.title }}</h4>
        <p>{{ blog.description }}</p>
        <span class="tag-test">{{ blog.tag }}</span>
        <span class="mx-1 tag-test2">{{ blog.sub_tag }}</span>
      </article>
      <article class="border-2 rounded-2xl p-3 m-1">
        <h4>title</h4>
        <p>testcontent</p>
      </article>
    </div>
  </div>
</template>

<style scoped></style>
