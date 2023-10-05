// TODO: migrate to @catala-lang/catala-web-assets

%%raw(`
import familyBenefitsSchemaFr from "../assets/allocations_familiales_schema_fr.json";
import familyBenefitsUISchema from "../assets/allocations_familiales_ui_schema_fr.json";
import familyBenefitsHtml from "../assets/allocations_familiales.html?raw";

import {uiSchema as housingBenefitsUISchemaFr} from "../assets/aides_logement_ui_fr.schema.jsx";
import housingBenefitsSchema from "../assets/aides_logement_schema_fr.json";
import housingBenefitsInitialData from "../assets/aides_logement_init.json";
import housingBenefitsHtml from "../assets/allocations_familiales.html?raw";
`)

type t = {
  schema: JSON.t,
  uiSchema: JSON.t,
  selectedOutput: CatalaRuntime.information,
  keysToIgnore: array<string>,
  initialData?: JSON.t,
  html?: string,
}

let frenchFamilyAssets: t = {
  schema: %raw(`familyBenefitsSchemaFr`),
  uiSchema: %raw(`familyBenefitsUISchema`),
  keysToIgnore: ["dIdentifiant"],
  selectedOutput: list{"InterfaceAllocationsFamiliales", "i_montant_versé"},
  html: %raw(`familyBenefitsHtml`),
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

let frenchHousingAssets: t = {
  schema: %raw(`housingBenefitsSchema`),
  uiSchema: %raw(`housingBenefitsUISchemaFr`),
  initialData: alLocatifExemple4,
  html: %raw(`housingBenefitsHtml`),
  selectedOutput: list{"CalculetteAidesAuLogementGardeAlternée", "aide_finale"},
  keysToIgnore: ["identifiant"],
}
