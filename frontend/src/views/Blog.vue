<script setup>
import { ref } from 'vue';
import BlogContent from '@/components/BlogContent.vue';
import { useRouter } from 'vue-router';

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

const router = useRouter();

const goToPost = () => {
  // 今後認証チェックを追加するため、RouterLinkではなくuseRouterを使用
  router.push('/blogPost');
};

fetchBlogs();
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <div class="flex justify-start">
      <h3 class="column">Blog</h3>
    </div>
    <div class="flex justify-end">
      <button @click="goToPost">+new</button>
    </div>
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
