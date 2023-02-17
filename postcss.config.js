const purgecss = require("@fullhuman/postcss-purgecss")({
  // Specify the paths to all ReasonML code where you're using this PPX.
  content: ["./src/**/*.res"],

  // Include the extractor from this package
  defaultExtractor: require("@dylanirlbeck/tailwind-ppx").extractor,
});

const tailwindcss = require("tailwindcss");
const autoprefixer = require("autoprefixer");

module.exports = {
  plugins: [
    tailwindcss("./tailwind.config.js"),
    autoprefixer("autoprefixer"),
    ...(process.env.NODE_ENV === "production" ? [purgecss] : []),
  ],
};
