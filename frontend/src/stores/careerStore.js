import { defineStore } from 'pinia';

export const useCareerStore = defineStore('career', {
  state: () => ({
    careers: [],
    fetched: false, // 情報を取得すみかどうかのフラグ
    error: null,
    loading: true,
  }),
  actions: {
    async fetchCareers() {
      if (this.fetched) return; // 取得済みの場合は何もしない

      this.error = null;
      try {
        const res = await fetch(`${import.meta.env.VITE_API_URL}/careers`);
        if (!res.ok) throw new Error(`API error: ${res.status}`);
        this.careers = await res.json();
        this.fetched = true;
      } catch (e) {
        this.error = e.message;
        console.error(`Failed to fetch careers: ${e}`);
      } finally {
        this.loading = false;
      }
    },
  },
});
