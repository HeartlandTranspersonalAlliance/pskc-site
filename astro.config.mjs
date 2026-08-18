// @ts-check
import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import icon from "astro-icon";
import tailwindcss from "@tailwindcss/vite";

const isProductionRepository = process.env.GITHUB_REPOSITORY?.endsWith("/pskc-site");
const base = isProductionRepository ? "/" : "/pskc-staging";
const site = isProductionRepository
  ? "https://psychedelickc.org"
  : "https://heartlandtranspersonalalliance.github.io/pskc-staging";

export default defineConfig({
  site,
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
