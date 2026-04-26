import pluginVue from 'eslint-plugin-vue';
import xoConfig from 'eslint-config-xo';
import { defineConfig } from 'eslint/config';

export default defineConfig([
  ...pluginVue.configs['flat/recommended'],
  {
    files: ['**/*.{js,ts,jsx,tsx}'],
    ...xoConfig(),
  },
]);
