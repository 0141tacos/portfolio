<script setup>
import { ref, onMounted } from "vue";

const featureData = ref({});

onMounted(async () => {
  const response = await fetch("/feature.json");
  const json = await response.json();
  featureData.value = json;
});
</script>

<template>
  <div class="" id="{category}" v-for="(entries, category) in featureData" :key="category">
    <h3>{{ category }}</h3>
    <ul>
      <dl class="" v-for="entry in entries" :key="entry.item">
        <dt class="">{{ entry.item }}</dt>
        <dd class="" v-if="entry.content">{{ entry.content }}</dd>
      </dl>
    </ul>
  </div>
</template>

<style></style>
