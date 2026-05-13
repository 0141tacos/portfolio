<script setup>
import { onMounted } from 'vue';
import { useCareerStore } from '@/stores/careerStore';
import { useSkillStore } from '@/stores/skillStore';
import { useHobbyStore } from '@/stores/hobbyStore';
import { useCertificationStore } from '@/stores/certificationStore';

const careerStore = useCareerStore();
const skillStore = useSkillStore();
const hobbyStore = useHobbyStore();
const certificationStore = useCertificationStore();

careerStore.fetchCareers();
skillStore.fetchSkills();
hobbyStore.fetchHobbies();
certificationStore.fetchCertifications();
</script>

<template>
  <div id="career" class="m-1">
    <h3 class="text-2xl">Career</h3>
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

  <div class="m-1">
    <h3 class="text-2xl">Skills</h3>
    <div v-if="skillStore.error" class="m-1">
      <p>Failed to fetch skills.</p>
    </div>
    <div v-else-if="skillStore.loading" class="m-1">
      <p>Loading...</p>
    </div>
    <div v-else>
      <dl class="m-1" v-for="skill in skillStore.skills" :key="skill.id">
        <dt class="font-light">{{ skill.skill_name }}</dt>
        <dd
          class="text-sm text-text-secondary font-thin"
          v-if="skill.description"
        >
          {{ skill.description }}
        </dd>
      </dl>
    </div>

    <h3 class="text-2xl">Certifications</h3>
    <div v-if="certificationStore.error" class="m-1">
      <p>Failed to fetch certifications.</p>
    </div>
    <div v-else-if="certificationStore.loading" class="m-1">
      <p>Loading...</p>
    </div>
    <div v-else>
      <dl
        class="m-1"
        v-for="certification in certificationStore.certifications"
        :key="certification.id"
      >
        <dt class="font-light">{{ certification.certification_name }}</dt>
        <dd
          class="text-sm text-text-secondary font-thin"
          v-if="certification.description"
        >
          {{ certification.description }}
        </dd>
      </dl>
    </div>

    <h3 class="text-2xl">Hobbies</h3>
    <div v-if="hobbyStore.error" class="m-1">
      <p>Failed to fetch hobbies.</p>
    </div>
    <div v-else-if="hobbyStore.loading" class="m-1">
      <p>Loading...</p>
    </div>
    <div v-else>
      <dl class="m-1" v-for="hobby in hobbyStore.hobbies" :key="hobby.id">
        <dt class="font-light">{{ hobby.hobby_name }}</dt>
        <dd
          class="text-sm text-text-secondary font-thin"
          v-if="hobby.description"
        >
          {{ hobby.description }}
        </dd>
      </dl>
    </div>
  </div>
</template>

<style></style>
