type t = {
  getWebAssets: string => WebAssets.t,
  name: string,
  resultLabel: string,
  url: string,
  formDataPostProcessing?: JSON.t => JSON.t,
  computeAndPrintResult: (FrenchLaw.t, JSON.t) => React.element,
}
