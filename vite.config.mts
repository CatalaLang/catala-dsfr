/// <reference types="vite/client" />

import { defineConfig } from "vite";
import tailwindcss from "tailwindcss";
import react from "@vitejs/plugin-react";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";
import { viteCommonjs } from "@originjs/vite-plugin-commonjs";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), createReScriptPlugin(), viteCommonjs()],
  server: {
    watch: {
      include: ["./src/**/*.{js, tsx}", "./assets/**/*"],
      ignored: ["**/dsfr/**/*", "**/node_modules/**/*", "**/lib/**/*"],
      usePolling: true,
    },
  },
  css: {
    postcss: {
      plugins: [tailwindcss],
    },
  },
  build: {
    commonjsOptions: {
      transformMixedEsModules: true,
    },
  },
  assetsInclude: ["./assets/*.html"],
});
