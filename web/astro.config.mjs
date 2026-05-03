import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

// Production canonical URL — used for sitemap, OpenGraph absolute URLs, etc.
const SITE = 'https://www.willou.com';
const BASE = '/MythicKeystone';

export default defineConfig({
  site: SITE,
  base: BASE,
  trailingSlash: 'always',
  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'fr'],
    routing: {
      prefixDefaultLocale: true,
    },
  },
  build: {
    format: 'directory',
  },
  integrations: [
    sitemap({
      i18n: {
        defaultLocale: 'en',
        locales: { en: 'en', fr: 'fr' },
      },
    }),
  ],
});
