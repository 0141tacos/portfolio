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
  <div id="career">
    <h3>Career</h3>
    <ul class="">
      <li class="row" v-for="item in careerData" :key="item.id">
        <span class="col">{{ item.period }}</span>
        <span class="col">:</span>
        <span class="col">{{ item.position }}</span>
      </li>
    </ul>
  </div>
</template>

<style></style>
