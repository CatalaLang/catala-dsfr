let infos: FormInfos.t = {
  getWebAssets: CatalaWebAssets.getAllocationsFamiliales,
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
  computeAndPrintResult: (frenchLaw, input) => {
    let res = input->frenchLaw.computeAllocationsFamiliales->Float.toString
    <>
      <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
        {React.string(res)}
      </span>
      {React.string(` €`)}
    </>
  },
}
