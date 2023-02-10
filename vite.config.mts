/// <reference types="vite/client" />

import { defineConfig } from "vite";
import tailwindcss from "tailwindcss";
import react from "@vitejs/plugin-react";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";
import commonjsExternals from "vite-plugin-commonjs-externals";

const externals = [/french_law.js$/];

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    createReScriptPlugin(),
    // commonjsExternals({
    //   externals,
    // }),
    // requireTransform({ fileRegex: /.*\.bs\.js$|.js$/ }),
  ],
  optimizeDeps: {
    exclude: ["french_law.js", "./assets/french_law.js"],
  },
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
  build: {
    commonjsOptions: {
      transformMixedEsModules: true,
    },
  },
  assetsInclude: ["./assets/*.html", /french_law.js$/],
  // test: {
  //   include: ['tests/**/*_test.bs.js'],
  //   globals: true,
  //   environment: 'jsdom',
  //   setupFiles: './tests/setup.ts',
  // },
});
