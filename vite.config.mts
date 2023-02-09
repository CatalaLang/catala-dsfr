/// <reference types="vite/client" />

import { defineConfig } from "vite";
import tailwindcss from "tailwindcss";
import react from "@vitejs/plugin-react";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), createReScriptPlugin()],
  server: {
    watch: {
      ignored: ["./public/dsfr/**/*"],
    },
  },
  css: {
    postcss: {
      plugins: [tailwindcss],
    },
  },
  // test: {
  //   include: ['tests/**/*_test.bs.js'],
  //   globals: true,
  //   environment: 'jsdom',
  //   setupFiles: './tests/setup.ts',
  // },
});
