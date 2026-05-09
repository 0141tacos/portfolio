<script setup>
import { onMounted } from 'vue';
import { useSkillStore } from '@/stores/skillStore';

const skillStore = useSkillStore();

onMounted(async () => {
  await skillStore.fetchSkills();
});
</script>

<template>
  <div class="m-1">
    <h3 class="text-2xl">Skills</h3>
    <div v-if="skillStore.error" class="m-1">
      <p>Failed to fetch skills.</p>
    </div>
    <div v-else-if="skillStore.loading" class="m-1">
      <p>Loading...</p>
    </div>
    <ul v-else class="m-1">
      <dl class="" v-for="skill in skillStore.skills" :key="skill.id">
        <dt class="font-light">{{ skill.skill_name }}</dt>
        <dd
          class="text-sm text-text-secondary font-thin"
          v-if="skill.description"
        >
          {{ skill.description }}
        </dd>
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
