<script setup>
import { ref } from 'vue';
import BlogContent from '@/components/BlogContent.vue';

const blogs = ref([]);

const fetchBlogs = async () => {
  try {
    const res = await fetch(`${import.meta.env.VITE_API_URL}/blogs`);
    if (!res.ok) throw new Error(`API error: ${res.status}`);
    blogs.value = await res.json();
  } catch (e) {
    console.error('Fail to fetch blogs', e);
  }
};

fetchBlogs();
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <h3 class="text-2xl">Blog</h3>
    <div id="blog" class="m-1">
      <BlogContent v-for="blog in blogs" :key="blog.id" :blog="blog" />
    </div>
  </div>
</template>

<style scoped></style>
