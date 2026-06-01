// @ts-check
import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import icon from "astro-icon";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  site: "https://heartlandtranspersonalalliance.github.io",
  base: "/pskc-staging",
  trailingSlash: "always",
  integrations: [
    sitemap(),
    icon({
      include: {
        tabler: ["*"],
      },
    }),
  ],
  vite: {
    plugins: [tailwindcss()],
  },
});
