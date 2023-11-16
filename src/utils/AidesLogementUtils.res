let formInfos: FormInfos.t = {
  webAssets: WebAssets.aidesLogementAssets,
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
  computeAndPrintResult: input => <>
    <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
      {input->CatalaFrenchLaw.computeAidesAuLogement->Belt.Float.toString->React.string}
    </span>
    {React.string(` €`)}
  </>,
}
