type t = {
  webAssets: WebAssets.t,
  name: string,
  resultLabel: string,
  url: string,
  formDataPostProcessing?: JSON.t => JSON.t,
  computeAndPrintResult: JSON.t => promise<React.element>,
}
