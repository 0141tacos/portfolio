<script setup>
import { ref, onMounted } from "vue";

const careerData = ref({});

onMounted(async () => {
  const response = await fetch("/career.json");
  const json = await response.json();
  careerData.value = json.career;
  console.log(careerData.value);
});
</script>

<template>
  <div id="career" class="m-1">
    <h3 class="text-2xl">Career</h3>
    <ul class="list-none m-1">
      <li class="grid grid-cols-8" v-for="item in careerData" :key="item.id">
        <span class="col-span-2">{{ item.period }}</span>
        <span class="col-span-1">:</span>
        <span class="col-span-2">{{ item.position }}</span>
      </li>
    </ul>
  </div>
</template>

<style></style>
