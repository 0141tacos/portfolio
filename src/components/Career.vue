<script setup>
import { ref, onMounted } from 'vue';

const careerData = ref({});

onMounted(async () => {
  const response = await fetch('/career.json');
  const json = await response.json();
  careerData.value = json.career;
  console.log(careerData.value);
});
</script>

<template>
  <div id="career" class="m-1">
    <h3 class="text-2xl">Career</h3>
    <ul class="list-none m-1">
      <li class="flex" v-for="item in careerData" :key="item.id">
        <span class="w-40">{{ item.period }}</span>
        <span class="w-5">:</span>
        <span class="w-35">{{ item.position }}</span>
      </li>
    </ul>
  </div>
</template>

<style></style>
