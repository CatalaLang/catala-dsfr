type t = {
  getWebAssets: string => CatalaWebAssets.t,
  name: string,
  resultLabel: string,
  url: string,
  formDataPostProcessing?: JSON.t => JSON.t,
  computeAndPrintResult: (FrenchLaw.t, JSON.t) => React.element,
}
