%%raw(`
import familyBenefitsSchemaFr from "../../assets/v0.8.9/allocations_familiales_schema_fr.json";
import familyBenefitsUISchema from "../../assets/v0.8.9/allocations_familiales_ui_schema_fr.json";
import familyBenefitsHtml from "../../assets/v0.8.9/allocations_familiales.html?raw";

import {uiSchema as housingBenefitsUISchemaFr} from "../../assets/v0.8.9/aides_logement_ui_fr.schema.jsx";
import housingBenefitsSchema from "../../assets/v0.8.9/aides_logement_schema_fr.json";
import housingBenefitsInitialData from "../../assets/v0.8.9/aides_logement_init.json";
import housingBenefitsHtml from "../../assets/v0.8.9/aides_logement.html?raw";
`)

open Vite

module Versions = {
  let assetsImports = Import.Meta.glob("../../assets/**/*.{json,js,jsx}")
  let sourceCodesImports = Import.Meta.globWithOpts("../../assets/**/*.html", {as_: "raw"})

  let available =
    assetsImports
    ->Dict.keysToArray
    ->Array.map(key => key->String.split("/")->Array.getUnsafe(3))
    ->Utils.toUnique

  let latest = available->Array.get(0)->Option.getExn
}

type t = {
  schemaImport: getPromise<JSON.t>,
  uiSchemaImport: getPromise<JSON.t>,
  initialDataImport?: getPromise<JSON.t>,
  selectedOutput: CatalaRuntime.information,
  keysToIgnore: array<string>,
}

let getAllocationsFamiliales = version => {
  let schema =
    Versions.assetsImports->Dict.get(
      `../../assets/${version}/allocations_familiales_schema_fr.json`,
    )
  let uiSchema =
    Versions.assetsImports->Dict.get(
      `../../assets/${version}/allocations_familiales_ui_schema_fr.json`,
    )
  switch (schema, uiSchema) {
  | (Some(schemaImport), Some(uiSchemaImport)) => {
      schemaImport: async () => (await schemaImport())->Utils.getFromJSONExn("default"),
      uiSchemaImport: async () => (await uiSchemaImport())->Utils.getFromJSONExn("default"),
      keysToIgnore: ["dIdentifiant"],
      selectedOutput: list{"InterfaceAllocationsFamiliales", "i_montant_versé"},
    }
  | _ => Js.Exn.raiseError(`Version ${version} not found in ${Versions.available->Array.toString}`)
  }
}

let allocationsFamilialesAssets: t = getAllocationsFamiliales(Versions.latest)
let getAllocationsFamilialesSourceCode = (version): getPromise<string> =>
  switch Versions.sourceCodesImports->Dict.get(
    `../../assets/${version}/allocations_familiales.html`,
  ) {
  | Some(htmlImport) => htmlImport
  | None =>
    Js.Exn.raiseError(
      `HTML source code for version ${version} not found in ${Versions.available->Array.toString}`,
    )
  }

let getAidesLogement = version => {
  let schema =
    Versions.assetsImports->Dict.get(`../../assets/${version}/aides_logement_schema_fr.json`)
  let uiSchema =
    Versions.assetsImports->Dict.get(`../../assets/${version}/aides_logement_ui_fr.schema.jsx`)
  let initialData =
    Versions.assetsImports->Dict.get(`../../assets/${version}/aides_logement_init.json`)

  switch (schema, uiSchema, initialData) {
  | (Some(schemaImport), Some(uiSchemaImport), Some(initialDataImport)) => {
      schemaImport: async () => (await schemaImport())->Utils.getFromJSONExn("default"),
      uiSchemaImport: async () =>
        (await uiSchemaImport())->Utils.getFromJSONExn("uiSchema")->Utils.getFromJSONExn("default"),
      initialDataImport: async () => (await initialDataImport())->Utils.getFromJSONExn("default"),
      selectedOutput: list{"CalculetteAidesAuLogementGardeAlternée", "aide_finale"},
      keysToIgnore: ["identifiant"],
    }
  | _ => Js.Exn.raiseError(`Version ${version} not found in ${Versions.available->Array.toString}`)
  }
}

let aidesLogementAssets: t = getAidesLogement(Versions.latest)

let getAidesLogementSourceCode = (version): getPromise<string> =>
  switch Versions.sourceCodesImports->Dict.get(`../../assets/${version}/aides_logement.html`) {
  | Some(htmlImport) => htmlImport
  | None =>
    Js.Exn.raiseError(
      `HTML source code for version ${version} not found in ${Versions.available->Array.toString}`,
    )
  }
