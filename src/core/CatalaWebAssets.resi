type t = {
  schemaImport: unit => promise<RescriptCore.JSON.t>,
  uiSchemaImport: unit => promise<RescriptCore.JSON.t>,
  initialDataImport?: unit => promise<RescriptCore.JSON.t>,
  selectedOutput: CatalaRuntime.information,
  keysToIgnore: array<string>,
}
let getAllocationsFamiliales: string => t
let getAllocationsFamilialesSourceCode: (string, unit) => promise<string>
let getAidesLogement: string => t
let getAidesLogementSourceCode: (string, unit) => promise<string>
