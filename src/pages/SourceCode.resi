@react.component
let make: (
  ~version: string,
  ~htmlImport: WebAssets.importFn<string>,
  ~simulatorUrl: string,
) => React.element
