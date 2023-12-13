/// <reference types="vite/client" />

import { defineConfig } from "vite";
import tailwindcss from "tailwindcss";
import react from "@vitejs/plugin-react";
import rescript from "@jihchi/vite-plugin-rescript";
import { viteCommonjs } from "@originjs/vite-plugin-commonjs";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), rescript(), viteCommonjs()],
  server: {
    watch: {
      ignored: ["**/dsfr/**/*", "!**/node_modules/@catala-lang/**/*"],
    },
  },
  css: {
    postcss: {
      plugins: [tailwindcss],
    },
  },
  build: {
    sourcemap: true,
    commonjsOptions: {
      transformMixedEsModules: true,
    },
  },
  // NOTE: To uncomment when using linked local packages
  // optimizeDeps: {
  //   exclude: ["@catala-lang/catala-explain"],
  // },
  assetsInclude: ["./catala-web-assets/**/*.html"],
});
