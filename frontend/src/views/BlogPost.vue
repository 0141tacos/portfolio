<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const title = ref('');
const content = ref('');
const tag = ref('');
const sub_tag = ref('');

const postOk = ref(null);
const postError = ref(null);

const goToBlog = () => {
  router.push('/blog');
};

const postBlog = async () => {
  try {
    const res = await fetch(`${import.meta.env.VITE_API_URL}/blogs`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        title: title.value,
        content: content.value,
        tag: tag.value,
        sub_tag: sub_tag.value,
      }),
    });

    if (!res.ok) throw new Error(`API error ${res.status}`);
    postOk.value = 'Blog post created successfully';
  } catch (e) {
    console.error('Internal Server Error');
    postError.value = e.message;
  }
};
</script>

<template>
  <div class="container mx-auto min-w-xs">
    <h3>Blog Post</h3>
    <div v-if="postOk">
      <p>{{ postOk }}</p>
    </div>
    <div v-else-if="postError">
      <p>Failed to create post</p>
    </div>
    <div v-else class="flex flex-col">
      <h4>Title</h4>
      <input v-model="title" />
      <h4>Tag</h4>
      <input v-model="tag" />
      <h4>Sub Tag</h4>
      <input v-model="sub_tag" />
      <h4>Content</h4>
      <textarea v-model="content" />
    </div>
    <div class="flex flex-row justify-end">
      <button class="font-thin" @click="goToBlog">Back</button>
      <button v-if="!postOk && !postError" @click="postBlog">Post</button>
    </div>
  </div>
</template>

<style scoped></style>
