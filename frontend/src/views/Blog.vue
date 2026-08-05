<script setup>
import { ref } from 'vue';
import BlogContent from '@/components/BlogContent.vue';
import { supabase } from '@/lib/supabase.js';

const tags = ref([]);
const tagGetError = ref(null);
const fetchBlogTags = async () => {
  try {
    const { data, error } = await supabase.from('distinct_tags').select('tag');
    if (error) throw error;
    tags.value = data;
  } catch (e) {
    console.error('Failed to fetch blogs tag', e);
    tagGetError.value = e.message;
  }
  console.log(tags.value);
};

const blogs = ref([]);
const blogLoading = ref(false);
const blogError = ref(null);
const filterSelected = ref([]);
const fetchBlogs = async (tag) => {
  let query = supabase.from('blogs').select();
  console.log(filterSelected);
  if (tag && tag.length > 0) {
    query = query.in('tag', tag);
  }
  try {
    blogLoading.value = true;
    const { data, error } = await query;
    if (error) throw error;
    blogs.value = data;
  } catch (e) {
    console.error('Failed to fetch blogs', e);
    blogError.value = e.message;
  } finally {
    blogLoading.value = false;
  }
};

fetchBlogTags();
fetchBlogs();
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <div class="flex justify-start">
      <h3 class="column">Blog</h3>
    </div>

    <div>
      <h4>Filter</h4>
      <div v-if="tagGetError" class="m-1">
        <p>Failed to fetch blogs tag</p>
      </div>
      <div v-else>
        <select v-model="filterSelected" class="block" multiple>
          <option v-for="tag in tags" :key="tag" :value="tag.tag">
            {{ tag.tag }}
          </option>
        </select>
      </div>
      <button @click="fetchBlogs(filterSelected)">apply</button>
    </div>

    <div>
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
  </div>
</template>

<style scoped></style>
