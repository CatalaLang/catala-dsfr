/// <reference types="vite/client" />

import { defineConfig } from "vite";
import tailwindcss from "tailwindcss";
import react from "@vitejs/plugin-react";
import rescript from "@jihchi/vite-plugin-rescript";
import { viteCommonjs } from "@originjs/vite-plugin-commonjs";

// Needed to allow ending paths with a version number (e.g. /v1.0.0), if not
// the server will try to find a file with that name and fail.
const allowPathWithEndingVersionNumbers = () => ({
  name: "allow-path-with-ending-version-numbers",
  configureServer: (server) => {
    server.middlewares.use((req, _, next) => {
      const endPath = req.url.split("?", 2)[0].split("/").slice(-1)[0];
      if (endPath.match(/[0-9]\.[0-9]\.[0-9]/)) {
        req.url = "/";
      }
      next();
    });
  },
});

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    rescript(),
    viteCommonjs(),
    allowPathWithEndingVersionNumbers(),
  ],
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
