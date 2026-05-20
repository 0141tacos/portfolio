<script setup></script>

<template>
  <div class="m-1">
    <h3 class="text-2xl"></h3>
    <div v-if="careerStore.error" class="m-1">
      <p>Failed to fetch careers.</p>
    </div>
    <div v-else-if="careerStore.loading" class="m-1"><p>Loading...</p></div>
    <ul v-else class="list-none m-1">
      <li class="flex" v-for="career in careerStore.careers" :key="career.id">
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
