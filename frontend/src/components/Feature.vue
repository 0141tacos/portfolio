<script setup>
import { onMounted } from 'vue';
import { useSkillStore } from '@/stores/skillStore';
import { useHobbyStore } from '@/stores/hobbyStore';

const skillStore = useSkillStore();
const hobbyStore = useHobbyStore();

onMounted(async () => {
  await skillStore.fetchSkills();
  await hobbyStore.fetchHobbies();
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

    <h3 class="text-2xl">Hobbies</h3>
    <div v-if="hobbyStore.error" class="m-1">
      <p>Failed to fetch hobbies.</p>
    </div>
    <div v-else-if="hobbyStore.loading" class="m-1">
      <p>Loading...</p>
    </div>
    <ul v-else class="m-1">
      <dl class="" v-for="hobby in hobbyStore.hobbies" :key="hobby.id">
        <dt class="font-light">{{ hobby.hobby_name }}</dt>
        <dd
          class="text-sm text-text-secondary font-thin"
          v-if="hobby.description"
        >
          {{ hobby.description }}
        </dd>
      </dl>
    </ul>
  </div>
</template>

<style></style>
