let pageTitle =
  <Lang.String
    english="French family benefits computation" french={`Calcul des allocations familiales`}
  />

module FormInfos = {
  let webAssets = WebAssets.frenchFamilyAssets
  let name = `allocations familiales`
  let resultLabel = `Montant mensuel des ${name}`

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
	  }
  `)

  let computeAndPrintResult = (input: Js.Json.t): React.element => <>
    <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
      {input->CatalaFrenchLaw.computeAllocationsFamiliales->Belt.Float.toString->React.string}
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
