import { defineStore } from 'pinia';
import { supabase } from '@/lib/supabase.js';

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
        const { data, error } = await supabase.from('skills').select();
        if (error) throw new Error(`API error: ${error}`);
        this.skills = data;
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
