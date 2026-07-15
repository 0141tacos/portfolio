import { defineStore } from 'pinia';
import { supabase } from '@/lib/supabase.js';

export const useCareerStore = defineStore('career', {
  state: () => ({
    careers: [],
    fetched: false, // 情報を取得すみかどうかのフラグ
    error: null,
    loading: false,
  }),
  actions: {
    async fetchCareers() {
      if (this.fetched) return; // 取得済みの場合は何もしない

      this.error = null;
      this.loading = true;
      try {
        const { data, error } = await supabase.from('careers').select();
        if (error) throw new Error(`API error: ${error}`);
        this.careers = data;
        this.fetched = true;
      } catch (e) {
        this.error = e.message;
        console.error('Failed to fetch careers:', e);
      } finally {
        this.loading = false;
      }
    },
  },
});
