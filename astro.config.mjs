// @ts-check
import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import icon from "astro-icon";
import tailwindcss from "@tailwindcss/vite";

const base = process.env.GITHUB_REPOSITORY?.endsWith("/pskc-site") ? "/pskc-site" : "/pskc-staging";

export default defineConfig({
  site: "https://heartlandtranspersonalalliance.github.io",
  base,
  trailingSlash: "always",
  integrations: [
    sitemap({
      filter: (page) => !page.endsWith("/membership/"),
    }),
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
