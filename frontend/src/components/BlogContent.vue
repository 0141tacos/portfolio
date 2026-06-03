<script setup>
const props = defineProps({
  blog: {
    type: Object,
    required: true,
  },
});
</script>

<template>
  <div>
    <article class="border-2 rounded-2xl p-3 m-1">
      <h4 class="m-1">{{ blog.title }}</h4>
      <p class="m-1">{{ blog.description }}</p>
      <div class="m-1">
        <span v-if="blog.tag" class="mx-1 tag-test">{{ blog.tag }}</span>
        <span v-if="blog.sub_tag" class="mx-1 tag-test2">{{
          blog.sub_tag
        }}</span>
      </div>
    </article>
  </div>
</template>

<style></style>
