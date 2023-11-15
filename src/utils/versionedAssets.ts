type getAssets = () => Promise<any>;

export const versions = ["v0.9.0", "v0.8.9"];

export const versionedAssets: Record<string, getAssets> = import.meta.glob([
  "../../assets/**/*.{json,js,jsx}",
]);

export const versionedSources: Record<string, getAssets> = import.meta.glob(
  "../../assets/**/*.html",
  { as: "raw" },
);
