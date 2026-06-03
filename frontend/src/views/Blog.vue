<script setup>
import { ref } from 'vue';
import BlogContent from '@/components/BlogContent.vue';

const blogs = ref([]);
const blogLoading = ref(false);
const blogError = ref(null);

const fetchBlogs = async () => {
  try {
    blogLoading.value = true;
    const res = await fetch(`${import.meta.env.VITE_API_URL}/blogs`);
    if (!res.ok) throw new Error(`API error: ${res.status}`);
    blogs.value = await res.json();
  } catch (e) {
    console.error('Failed to fetch blogs', e);
    blogError.value = e.message;
  } finally {
    blogLoading.value = false;
  }
};

fetchBlogs();
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <h3 class="text-2xl">Blog</h3>
    <div v-if="blogLoading" class="m-1">
      <p>Loading...</p>
    </div>
    <div v-else-if="blogError" class="m-1">
      <p>Failed to fetch blogs</p>
    </div>
    <div v-else id="blog" class="m-1">
      <BlogContent v-for="blog in blogs" :key="blog.id" :blog="blog" />
    </div>
  </div>
</template>

<style scoped></style>
