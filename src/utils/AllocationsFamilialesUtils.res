let formInfos: FormInfos.t = {
  webAssets: WebAssets.allocationsFamilialesAssets,
  name: `allocations familiales`,
  resultLabel: `Montant mensuel des allocations`,
  url: "allocations-familiales",
  // This function automatically assigns numerical ID to kids so we don't
  // have to ask the question in the form
  formDataPostProcessing: %raw(`
	  function (data) {
		  var i = 0;
		  for (var enfant of data.iEnfantsIn) {
			  enfant.dIdentifiant = i;
			  i++;
		  }
		  return data;
	  }
  `),
  computeAndPrintResult: input => <>
    <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
      {input->CatalaFrenchLaw.computeAllocationsFamiliales->Belt.Float.toString->React.string}
    </span>
    {React.string(` €`)}
  </>,
}
