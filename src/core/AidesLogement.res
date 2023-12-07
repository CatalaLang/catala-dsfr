let infos: FormInfos.t = {
  getWebAssets: WebAssets.getAidesLogement,
  name: "aides au logement",
  resultLabel: `Montant mensuel brut des aides au logement`,
  url: "aides-au-logement",
  formDataPostProcessing: %raw(`
	function (data) {
	  var i = 0;
	  for (var pac of data.menageIn.personnesACharge) {
		if (pac.kind == "EnfantACharge") {
		  pac.payload.identifiant = i;
		  i++;
		}
	  }
	  return data;
	}
  `),
  computeAndPrintResult: (frenchLaw, input) => {
    let res = input->frenchLaw.computeAidesAuLogement->Float.toString
    <>
      <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
        {React.string(res)}
      </span>
      {React.string(` €`)}
    </>
  },
}
