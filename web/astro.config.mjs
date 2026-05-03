import { defineConfig } from 'astro/config';

// For GitHub Pages at https://<user>.github.io/MythicKeystone/
// Same base used in dev (URL is http://localhost:4321/MythicKeystone/en/).
const base = '/MythicKeystone';

export default defineConfig({
  site: 'https://example.github.io',
  base,
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
});
