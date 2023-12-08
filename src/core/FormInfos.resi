type t = {
  getWebAssets: string => CatalaWebAssets.t,
  name: string,
  resultLabel: string,
  url: string,
  formDataPostProcessing?: RescriptCore.JSON.t => RescriptCore.JSON.t,
  computeAndPrintResult: (FrenchLaw.t, RescriptCore.JSON.t) => React.element,
}
