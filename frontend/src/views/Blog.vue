<script setup>
import { ref } from 'vue';
import BlogContent from '@/components/BlogContent.vue';
import BlogFilter from '@/components/BlogFilter.vue';
import { BLOG_FILTER } from '@/constants/const.js';
import { supabase } from '@/lib/supabase.js';

// フィルター用の項目を取得する関数
const getItemForFilter = async (dbName, itemName, itemArray, itemGetError) => {
  try {
    const { data, error } = await supabase
      .from(dbName)
      .select(`name: ${itemName}`)
      .not(`${itemName}`, 'is', null)
      .neq(`${itemName}`, '');
    if (error) throw error;
    itemArray.value = data;
  } catch (e) {
    console.error(`Failed to fetch blog's ${itemName}`, e);
    itemGetError.value = e.message;
  }
};

// tag用変数
const tagsArray = ref([]);
const tagGetError = ref(null);
const tagsSelected = ref([]);

// subtag用変数
const subTagsArray = ref([]);
const subTagGetError = ref(null);
const subTagsSelected = ref([]);

const blogs = ref([]);
const blogLoading = ref(false);
const blogError = ref(null);
const fetchBlogs = async (tag, subtag) => {
  let query = supabase.from('blogs').select();
  if (tag && tag.length > 0) {
    query = query.in('tag', tag);
  }
  if (subtag && subtag.length > 0) {
    query = query.in('sub_tag', subtag);
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

const resetTag = () => {
  tagsSelected.value = [];
  subTagsSelected.value = [];
};

getItemForFilter('distinct_tags', BLOG_FILTER.TAG.var, tagsArray, tagGetError);
getItemForFilter(
  'distinct_sub_tags',
  BLOG_FILTER.SUBTAG.var,
  subTagsArray,
  subTagGetError
);
fetchBlogs();
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <div class="flex justify-start">
      <h3 class="column">Blog</h3>
    </div>

    <div>
      <h4>Filter</h4>
      <div>
        <div v-if="tagGetError" class="m-1">
          <p>Failed to fetch blog's tag</p>
        </div>
        <div v-else>
          <BlogFilter
            :filterCategory="BLOG_FILTER.TAG.name"
            :filterCategoryItemsArray="tagsArray"
            v-model:filterSelected="tagsSelected"
          />
        </div>
      </div>
      <div>
        <div v-if="subTagGetError" class="m-1">
          <p>Failed to fetch blog's sub_tag</p>
        </div>
        <div v-else>
          <BlogFilter
            :filterCategory="BLOG_FILTER.SUBTAG.name"
            :filterCategoryItemsArray="subTagsArray"
            v-model:filterSelected="subTagsSelected"
          />
        </div>
      </div>
      <button @click="fetchBlogs(tagsSelected, subTagsSelected)">apply</button>
      <button @click="resetTag">reset</button>
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
