// TODO: migrate to @catala-lang/catala-web-assets

%%raw(`
import familyBenefitsSchemaFr from "../../assets/v0.8.9/allocations_familiales_schema_fr.json";
import familyBenefitsUISchema from "../../assets/v0.8.9/allocations_familiales_ui_schema_fr.json";
import familyBenefitsHtml from "../../assets/v0.8.9/allocations_familiales.html?raw";

import {uiSchema as housingBenefitsUISchemaFr} from "../../assets/v0.8.9/aides_logement_ui_fr.schema.jsx";
import housingBenefitsSchema from "../../assets/v0.8.9/aides_logement_schema_fr.json";
import housingBenefitsInitialData from "../../assets/v0.8.9/aides_logement_init.json";
import housingBenefitsHtml from "../../assets/v0.8.9/aides_logement.html?raw";
`)

type importFn<'a> = unit => promise<'a>

module Versions = {
  type versionedAssets<'a> = Dict.t<importFn<'a>>

  let assetsImports: versionedAssets<
    JSON.t,
  > = %raw(`import.meta.glob(["../../assets/**/*.{json,js,jsx}"])`)

  let sourceCodesImports: versionedAssets<
    string,
  > = %raw(`import.meta.glob("../../assets/**/*.html", { as: "raw" })`)

  let available =
    assetsImports
    ->Dict.keysToArray
    ->Array.map(key => key->String.split("/")->Array.getUnsafe(3))
    ->Utils.toUnique

  let latest = available->Array.get(0)->Option.getExn
}

type t = {
  schemaImport: importFn<JSON.t>,
  uiSchemaImport: importFn<JSON.t>,
  initialDataImport?: importFn<JSON.t>,
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
let getAllocationsFamilialesSourceCode = version =>
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
//
let aidesLogementAssets: t = getAidesLogement(Versions.latest)
let getAidesLogementSourceCode = version =>
  switch Versions.sourceCodesImports->Dict.get(`../../assets/${version}/aides_logement.html`) {
  | Some(htmlImport) => htmlImport
  | None =>
    Js.Exn.raiseError(
      `HTML source code for version ${version} not found in ${Versions.available->Array.toString}`,
    )
  }

// Infered from: https://github.com/CatalaLang/catala/blob/master/examples/aides_logement/tests/tests_calcul_al_locatif.catala_fr#L93-L126
let alLocatifExemple4: JSON.t = %raw(`
	{
  "menageIn": {
    "prestationsRecues": [],
    "logement": {
      "residencePrincipale": true,
      "modeOccupation": {
        "kind": "Locataire",
        "payload": {
          "bailleur": {
            "kind": "BailleurPrive",
          },
          "beneficiaireAideAdulteOuEnfantHandicapes": false,
          "logementEstChambre": false,
          "colocation": false,
          "ageesOuHandicapAdultesHebergeesOnereuxParticuliers": false,
          "logementMeubleD8422": false,
          "changementLogementD8424": {
            "kind": "PasDeChangement",
            "payload": null,
          },
          "loyerPrincipal": 500,
        },
      },
      "proprietaire": {
        "kind": "Autre",
        "payload": null,
      },
      "loueOuSousLoueADesTiers": {
        "kind": "Non",
      },
      "usufruit": {
        "kind": "Autre",
        "payload": null,
      },
      "logementDecentL89462": true,
      "zone": {
        "kind": "Zone2",
      },
      "surfaceMCarres": 65,
    },
    "personnesACharge": [
      {
        "kind": "EnfantACharge",
        "payload": {
          "aDejaOuvertDroitAuxAllocationsFamiliales": true,
          "remunerationMensuelle": 0,
          "nationalite": {
            "kind": "Francaise",
            "payload": null,
          },
          "etudesApprentissageStageFormationProImpossibiliteTravail": false,
          "obligationScolaire": {
            "kind": "Pendant",
            "payload": null,
          },
          "situationGardeAlternee": {
            "kind": "PasDeGardeAlternee",
            "payload": null,
          },
          "dateDeNaissance": "2023-04-01",
          "identifiant": 0,
        },
      },
      {
        "kind": "EnfantACharge",
        "payload": {
          "aDejaOuvertDroitAuxAllocationsFamiliales": true,
          "remunerationMensuelle": 0,
          "nationalite": {
            "kind": "Francaise",
            "payload": null,
          },
          "etudesApprentissageStageFormationProImpossibiliteTravail": false,
          "obligationScolaire": {
            "kind": "Pendant",
            "payload": null,
          },
          "situationGardeAlternee": {
            "kind": "PasDeGardeAlternee",
            "payload": null,
          },
          "dateDeNaissance": "2016-01-01",
          "identifiant": 1,
        },
      },
    ],
    "nombreAutresOccupantsLogement": 0,
    "situationFamiliale": {
      "kind": "Celibataire",
      "payload": null,
    },
    "conditionRattacheFoyerFiscalParentIfi": false,
    "enfantANaitreApresQuatriemeMoisGrossesse": false,
    "personnesAgeesHandicapeesFoyerR8444": false,
    "residence": {
      "kind": "SaintPierreEtMiquelon",
      "payload": null,
    },
  },
  "demandeurIn": {
    "nationalite": {
      "kind": "Francaise",
      "payload": null,
    },
    "estNonSalarieAgricoleL7818L78146CodeRural": false,
    "magistratFonctionnaireCentreInteretsMaterielsFamiliauxHorsMayotte": false,
    "personneHebergeeCentreSoinLL162223SecuriteSociale": false,
    "dateNaissance": "1992-01-01",
  },
  "dateCouranteIn": "2023-04-01",
  "ressourcesMenagePrisesEnCompteIn": 12500,
}
`)

// let aidesLogementAssets: t = {
//   schema: %raw(`housingBenefitsSchema`),
//   uiSchema: %raw(`housingBenefitsUISchemaFr`),
//   initialData: %raw(`housingBenefitsInitialData`),
//   html: %raw(`housingBenefitsHtml`),
//   selectedOutput: list{"CalculetteAidesAuLogementGardeAlternée", "aide_finale"},
//   keysToIgnore: ["identifiant"],
// }
