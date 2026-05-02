<script setup>
import { onMounted } from 'vue';
import { useCareerStore } from '@/stores/careerStore';

const store = useCareerStore();

onMounted(async () => {
  await store.fetchCareers();
});
</script>

<template>
  <div id="career" class="m-1">
    <h3 class="text-2xl">Career</h3>
    <div v-if="store.error" class="m-1">
      <p>Failed to fetch careers.</p>
    </div>
    <div v-if="store.loading" class="m-1"><p>Loading...</p></div>
    <ul v-else class="list-none m-1">
      <li class="flex" v-for="career in store.careers" :key="career.id">
        <span class="w-40"
          >{{ career.period_from }}~{{ career.period_to ?? 'current' }}</span
        >
        <span class="w-5">:</span>
        <span class="w-35">{{ career.position }}</span>
      </li>
    </ul>
  </div>
</template>

<style></style>
