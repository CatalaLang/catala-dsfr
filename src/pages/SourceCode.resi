@react.component
let make: (
  ~version: string,
  ~htmlImport: Vite.getPromise<string>,
  ~simulatorUrl: string,
) => React.element
