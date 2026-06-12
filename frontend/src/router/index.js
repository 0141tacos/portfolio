import { createRouter, createWebHistory } from 'vue-router';
import Home from '@/views/Home.vue';
import Blog from '@/views/Blog.vue';
import BlogPost from '@/views/BlogPost.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/blog', component: Blog },
  { path: '/blogPost', component: BlogPost },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
