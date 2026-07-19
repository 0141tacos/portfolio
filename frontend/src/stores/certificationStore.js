import { defineStore } from 'pinia';
import { supabase } from '@/lib/supabase.js';

export const useCertificationStore = defineStore('certification', {
  state: () => ({
    certifications: [],
    fetched: false, // 情報を取得すみかどうかのフラグ
    error: null,
    loading: false,
  }),
  actions: {
    async fetchCertifications() {
      if (this.fetched) return; // 取得済みの場合は何もしない

      this.error = null;
      this.loading = true;
      try {
        const { data, error } = await supabase.from('certifications').select();
        if (error) throw error;
        this.certifications = data;
        this.fetched = true;
      } catch (e) {
        this.error = e.message;
        console.error('Failed to fetch certifications:', e);
      } finally {
        this.loading = false;
      }
    },
  },
});
