let pageTitle =
  <Lang.String
    english="French housing benefits computation" french={`Calcul des aides au logement`}
  />

module FormInfos = {
  let webAssets = WebAssets.frenchHousingAssets
  let resultLabel = `Montant mensuel brut des aides au logement`
  let name = "aides au logement"
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
      {input->CatalaFrenchLaw.computeAidesAuLogement->Belt.Float.toString->React.string}
    </span>
    {React.string(` €`)}
  </>
}

module Form = Form.Make(FormInfos)

@react.component
let make = () => {
  React.useEffect0(() => {
    // Reset the log when the page is loaded.
    CatalaFrenchLaw.resetLog()
    None
  })
  <div className="fr-container">
    <PageComponents.Title> pageTitle </PageComponents.Title>
    <Form setEventsOpt={_ => ()} />
  </div>
}
