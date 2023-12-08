open Vite

module Versions = {
  let assetsImports = Import.Meta.glob("../../catala-web-assets/**/*.{json,js,jsx}")
  let sourceCodesImports = Import.Meta.globWithOpts(
    "../../catala-web-assets/**/*.html",
    {as_: "raw"},
  )

  let available =
    assetsImports
    ->Dict.keysToArray
    ->Array.map(key => key->String.split("/")->Array.getUnsafe(3))
    ->SemVer.sort

  let latest = available->Array.getUnsafe(0)
}

type t = {
  schemaImport: unit => promise<JSON.t>,
  uiSchemaImport: unit => promise<JSON.t>,
  initialDataImport?: unit => promise<JSON.t>,
  selectedOutput: CatalaRuntime.information,
  keysToIgnore: array<string>,
}

let getAllocationsFamiliales = version => {
  let schema =
    Versions.assetsImports->Dict.get(
      `../../catala-web-assets/${version}/allocations_familiales_schema_fr.json`,
    )
  let uiSchema =
    Versions.assetsImports->Dict.get(
      `../../catala-web-assets/${version}/allocations_familiales_ui_schema_fr.json`,
    )
  switch (schema, uiSchema) {
  | (Some(schemaImport), Some(uiSchemaImport)) => {
      schemaImport: async () => {
        let schema = await schemaImport()
        schema->Utils.getFromJSONExn("default")
      },
      uiSchemaImport: async () => {
        let uiSchema = await uiSchemaImport()
        uiSchema->Utils.getFromJSONExn("default")
      },
      keysToIgnore: ["dIdentifiant"],
      selectedOutput: list{"InterfaceAllocationsFamiliales", "i_montant_versé"},
    }
  | _ => Js.Exn.raiseError(`Version ${version} not found in ${Versions.available->Array.toString}`)
  }
}

let allocationsFamilialesAssets: t = getAllocationsFamiliales(Versions.latest)
let getAllocationsFamilialesSourceCode = (version): (unit => promise<string>) =>
  switch Versions.sourceCodesImports->Dict.get(
    `../../catala-web-assets/${version}/allocations_familiales.html`,
  ) {
  | Some(htmlImport) => htmlImport
  | None =>
    Js.Exn.raiseError(
      `HTML source code for version ${version} not found in ${Versions.available->Array.toString}`,
    )
  }

let getAidesLogement = version => {
  let schema =
    Versions.assetsImports->Dict.get(
      `../../catala-web-assets/${version}/aides_logement_schema_fr.json`,
    )
  let uiSchema =
    Versions.assetsImports->Dict.get(
      `../../catala-web-assets/${version}/aides_logement_ui_fr.schema.jsx`,
    )
  let initialData =
    Versions.assetsImports->Dict.get(`../../catala-web-assets/${version}/aides_logement_init.json`)

  switch (schema, uiSchema, initialData) {
  | (Some(schemaImport), Some(uiSchemaImport), Some(initialDataImport)) => {
      schemaImport: async () => {
        let schema = await schemaImport()
        schema->Utils.getFromJSONExn("default")
      },
      uiSchemaImport: async () => {
        let uiSchema = await uiSchemaImport()
        uiSchema->Utils.getFromJSONExn("uiSchema")
      },
      initialDataImport: async () => {
        let initialData = await initialDataImport()
        initialData->Utils.getFromJSONExn("default")
      },
      selectedOutput: list{"CalculetteAidesAuLogementGardeAlternée", "aide_finale"},
      keysToIgnore: ["identifiant"],
    }
  | _ => Js.Exn.raiseError(`Version ${version} not found in ${Versions.available->Array.toString}`)
  }
}

let aidesLogementAssets: t = getAidesLogement(Versions.latest)

let getAidesLogementSourceCode = (version): (unit => promise<string>) =>
  switch Versions.sourceCodesImports->Dict.get(
    `../../catala-web-assets/${version}/aides_logement.html`,
  ) {
  | Some(htmlImport) => htmlImport
  | None =>
    Js.Exn.raiseError(
      `HTML source code for version ${version} not found in ${Versions.available->Array.toString}`,
    )
  }
