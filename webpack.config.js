const path = require("path");
const webpack = require("webpack");

const CopyPlugin = require("copy-webpack-plugin");
const FaviconsWebpackPlugin = require("favicons-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const isProd = process.env.NODE_ENV === "production";
const outputDir = path.join(__dirname, "dist/");

var catala = {
  entry: "./src/App.bs.js",
  output: {
    path: outputDir,
    filename: "App.js",
    publicPath: "/",
  },
  mode: isProd ? "production" : "development",
  resolve: {
    alias: {
      fs: "browserfs/dist/shims/fs.js",
      buffer: "browserfs/dist/shims/buffer.js",
      path: "browserfs/dist/shims/path.js",
      processGlobal: "browserfs/dist/shims/process.js",
      bufferGlobal: "browserfs/dist/shims/bufferGlobal.js",
      bfsGlobal: require.resolve("browserfs"),
      child_process: "browser-builtins/builtin/child_process.js",
    },
    fallback: { constants: require.resolve("constants-browserify") },
  },
  devtool: "source-map",
  plugins: [
    new HtmlWebpackPlugin({
      filename: "index.html",
      template: "index.html",
    }),
    new CopyPlugin({
      patterns: [{ from: "./public/dsfr", to: "dsfr" }],
    }),
    new FaviconsWebpackPlugin({
      logo: "./assets/logo.png",
      mode: "webapp", // optional can be 'webapp' or 'light' - 'webapp' by default
      devMode: "webapp", // optional can be 'webapp' or 'light' - 'light' by default
      inject: true,
      favicons: {
        appName: "Catala",
        icons: {
          coast: false,
          yandex: false,
        },
      },
    }),
    new webpack.ProvidePlugin({
      BrowserFS: "bfsGlobal",
      process: "processGlobal",
      Buffer: "bufferGlobal",
    }),
  ],
  devServer: {
    compress: true,
    static: outputDir,
    port: process.env.PORT || 8000,
    historyApiFallback: true,
  },
  module: {
    noParse: /browserfs\.js/,
    rules: [
      {
        test: /\.schema.js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: "babel-loader",
          options: {
            presets: [
              "@babel/preset-env",
              ["@babel/preset-react", { runtime: "automatic" }],
            ],
          },
        },
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader", "postcss-loader"],
      },
      {
        test: /\.html$/,
        loader: "html-loader",
        options: {
          esModule: false,
        },
      },
      {
        test: /\.catala_en/,
        use: ["raw-loader"],
      },
      {
        test: /\.catala_fr/,
        use: ["raw-loader"],
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        use: ["file-loader?name=assets/[name].[ext]"],
      },
    ],
  },
};

module.exports = catala;
