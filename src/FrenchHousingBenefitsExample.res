let pageTitle =
  <Lang.String
    english="French housing benefits computation" french={`Calcul des aides au logement`}
  />

/* let catalaCodeHTML = %raw(`require("../assets/aides_logement.html")`) */
let frenchUiSchema = %raw(`require("../assets/aides_logement_ui_fr.schema.jsx")`)
let englishUiSchema = %raw(`require("../assets/aides_logement_ui_en.schema.jsx")`)

module FormInfos = {
  let englishSchema = %raw(`require("../assets/aides_logement_schema_en.json")`)
  let frenchSchema = %raw(`require("../assets/aides_logement_schema_fr.json")`)

  let frenchUiSchema = Js.Dict.unsafeGet(frenchUiSchema, "uiSchema")

  let englishUiSchema = Js.Dict.unsafeGet(englishUiSchema, "uiSchema")

  let resultLabel = `Montant mensuel brut des aides au logement`

  let initFormData = Some(
    %raw(`
{
    "menageIn": {
        "prestationsRecues": [],
        "logement": {
            "residencePrincipale": true,
            "estEhpadOuMaisonAutonomieL31312Asf": false,
            "modeOccupation": {
                "kind": "Locataire",
                "payload": {
                    "bailleur": {
                      "kind": "BailleurPrive"
                    },
                    "beneficiaireAideAdulteOuEnfantHandicapes": false,
                    "logementEstChambre": false,
                    "colocation": false,
                    "ageesOuHandicapAdultesHebergeesOnereuxParticuliers": false,
                    "reductionLoyerSolidarite": 0,
                    "logementMeubleD8422": false,
                    "changementLogementD8424": {
                        "kind": "PasDeChangement",
                        "payload": null
                    },
                    "loyerPrincipal": 450
                }
            },
            "proprietaire": {
                "kind": "Autre",
                "payload": null
            },
            "loueOuSousLoueADesTiers": {
                "kind": "Non"
            },
            "usufruit": {
                "kind": "Autre",
                "payload": null
            },
            "logementDecentL89462": true,
            "zone": {
                "kind": "Zone2"
            },
            "surfaceMCarres": 65
        },
        "personnesACharge": [
            {
                "kind": "EnfantACharge",
                "payload": {
                    "beneficieTitrePersonnelAidePersonnelleLogement": false,
                    "aDejaOuvertDroitAuxAllocationsFamiliales": true,
                    "remunerationMensuelle": 0,
                    "obligationScolaire": {
                        "kind": "Pendant"
                    },
                    "situationGardeAlternee": {
                        "kind": "PasDeGardeAlternee"
                    },
                    "dateDeNaissance": "2015-01-01",
                    "identifiant": 0
                }
            },
            {
                "kind": "EnfantACharge",
                "payload": {
                    "beneficieTitrePersonnelAidePersonnelleLogement": false,
                    "aDejaOuvertDroitAuxAllocationsFamiliales": true,
                    "remunerationMensuelle": 0,
                    "obligationScolaire": {
                        "kind": "Pendant"
                    },
                    "situationGardeAlternee": {
                        "kind": "PasDeGardeAlternee"
                    },
                    "dateDeNaissance": "2016-01-01",
                    "identifiant": 1
                }
            }
        ],
        "nombreAutresOccupantsLogement": 0,
        "situationFamiliale": {
            "kind": "Concubins",
            "payload": null
        },
        "conditionRattacheFoyerFiscalParentIfi": false,
        "nombreEnfantsANaitreApresTroisiemeMoisGrossesse": 0,
    },
    "demandeurIn": {
        "nationalite": {
            "kind": "Francaise"
        },
        "patrimoine": {
            "produisantRevenuPeriodeR82233R8224": 0,
            "neProduisantPasRevenuPeriodeR82233R8224": 0
        },
        "personneHebergeeCentreSoinLL162223SecuriteSociale": false,
        "dateNaissance": "1992-01-01"
    },
    "dateCouranteIn": "2022-05-01",
    "ressourcesMenagePrisesEnCompteIn": 11500
}
`),
  )
  // This function automatically assigns numerical ID to kids so we don't
  // have to ask the question in the form
  let formDataPostProcessing = %raw(`
function (data) {
  var i = 0;
  for (var pac of data.menageIn.personnesACharge) {
    if (pac.kind == "EnfantACharge") {
      pac.payload.identifiant = i;
      i++;
    }
  }
  return data;
}`)

  let computeAndPrintResult = (input: Js.Json.t): React.element => <>
    <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
      {input->FrenchLaw.computeAidesAuLogement->Belt.Float.toString->React.string}
    </span>
    {React.string(` €`)}
  </>
}

module Form = Form.Make(FormInfos)

@react.component
let make = () => {
  React.useEffect0(() => {
    // Reset the log when the page is loaded.
    FrenchLaw.resetLog()
    None
  })
  <div className="fr-container">
    <PageComponents.Title> pageTitle </PageComponents.Title> <Form setEventsOpt={_ => ()} />
  </div>
}
