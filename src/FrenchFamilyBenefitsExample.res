let pageTitle =
  <Lang.String
    english="French family benefits computation" french={`Calcul des allocations familiales`}
  />

let catalaCodeHTML = %raw(`require("../assets/allocations_familiales.html")`)
/* let frenchUISchema = %raw(`require("../assets/allocations_familiales_ui_schema_fr.tsx")`) */

module FormInfos = {
  let englishSchema = %raw(`require("../assets/allocations_familiales_schema_en.json")`)
  let frenchSchema = %raw(`require("../assets/allocations_familiales_schema_fr.json")`)

  let englishUiSchema = %raw(`require("../assets/allocations_familiales_ui_schema_en.json")`)
  /* let frenchUiSchema = Js.Dict.unsafeGet(frenchUISchema, "uiSchema") */
  let frenchUiSchema = %raw(`require("../assets/allocations_familiales_ui_schema_fr.json")`)

  let initFormData = None

  // This function automatically assigns numerical ID to kids so we don't
  // have to ask the question in the form
  let formDataPostProcessing = %raw(`
function (data) {
   var i = 0;
   for (var enfant of data.iEnfantsIn) {
     enfant.dIdentifiant = i;
     i++;
   }
   return data;
}`)
  let resultLabel = `Montant mensuel des allocations familiales`

  let computeAndPrintResult = (input: Js.Json.t): React.element => <>
    <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
      {input->FrenchLaw.computeAllocationsFamiliales->Belt.Float.toString->React.string}
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
