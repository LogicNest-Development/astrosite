import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://YOUR_DOMAIN',
  integrations: [tailwind({
    config: { applyBaseStyles: false }
  })],
});
