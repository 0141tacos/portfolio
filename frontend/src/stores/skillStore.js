import { defineStore } from 'pinia';

export const useSkillStore = defineStore('skill', {
  state: () => ({
    skills: [],
    fetched: false, // 情報を取得すみかどうかのフラグ
    error: null,
    loading: false,
  }),
  actions: {
    async fetchSkills() {
      if (this.fetched) return; // 取得済みの場合は何もしない

      this.error = null;
      this.loading = true;
      try {
        const res = await fetch(`${import.meta.env.VITE_API_URL}/skills`);
        if (!res.ok) throw new Error(`API error: ${res.status}`);
        this.skills = await res.json();
        this.fetched = true;
      } catch (e) {
        this.error = e.message;
        console.error('Failed to fetch skills:', e);
      } finally {
        this.loading = false;
      }
    },
  },
});
