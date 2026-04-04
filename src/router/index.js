import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import Blog from '@/views/Blog.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/blog', component: Blog },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
