<script setup>
import { ref } from 'vue';
import BlogContent from '@/components/BlogContent.vue';
import { supabase } from '@/lib/supabase.js';

const tags = ref([]);
const tagGetError = ref(null);
const filterSelected = ref([]);
const fetchBlogTags = async () => {
  try {
    const { data, error } = await supabase.from('distinct_tags').select('tag');
    if (error) throw error;
    tags.value = data;
  } catch (e) {
    console.error('Failed to fetch blogs tag', e);
    tagGetError.value = e.message;
  }
};

const blogs = ref([]);
const blogLoading = ref(false);
const blogError = ref(null);
const fetchBlogs = async (tag) => {
  let query = supabase.from('blogs').select();
  if (tag && tag.length > 0) {
    query = query.in('tag', tag);
  }
  try {
    blogLoading.value = true;
    blogError.value = null;
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
        <p>Failed to fetch blog's tag</p>
      </div>
      <div v-else>
        <details>
          <summary>
            Tag:
            <template v-if="filterSelected && filterSelected.length">
              <span
                v-for="selectedTag in filterSelected"
                :key="selectedTag"
                class="mx-1 tag-test"
              >
                {{ selectedTag }}
              </span>
            </template>
            <span v-else>select tag</span>
          </summary>
          <ul>
            <li v-for="tag in tags" :key="tag.tag">
              <label>
                <input
                  type="checkbox"
                  :value="tag.tag"
                  v-model="filterSelected"
                />
                {{ tag.tag }}
              </label>
            </li>
          </ul>
        </details>
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
