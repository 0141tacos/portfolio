import { defineStore } from 'pinia';

export const useCareerStore = defineStore('career', {
  state: () => ({
    careers: [],
    fetched: false, // 情報を取得すみかどうかのフラグ
  }),
  actions: {
    async fetchCareers() {
      if (this.fetched) return; // 取得済みの場合は何もしない

      const res = await fetch(`${import.meta.env.VITE_API_URL}/careers`);
      this.careers = await res.json();
      this.fetched = true;
    },
  },
});
