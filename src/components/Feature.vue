<script setup>
import { ref, onMounted } from 'vue';

const featureData = ref({});

onMounted(async () => {
  const response = await fetch('/feature.json');
  const json = await response.json();
  featureData.value = json;
});
</script>

<template>
  <div
    class="m-1"
    id="{category}"
    v-for="(entries, category) in featureData"
    :key="category"
  >
    <h3 class="text-2xl">{{ category }}</h3>
    <ul class="m-1">
      <dl class="" v-for="entry in entries" :key="entry.item">
        <dt class="font-light">{{ entry.item }}</dt>
        <dd class="text-sm text-text-secondary font-thin" v-if="entry.content">{{ entry.content }}</dd>
      </dl>
    </ul>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
    <h1>test</h1>
  </div>
</template>

<style></style>
