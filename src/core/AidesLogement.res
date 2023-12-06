let infos: FormInfos.t = {
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
  computeAndPrintResult: async input => {
    let res =
      (await FrenchLaw.get(FrenchLaw.Versions.latest)()).computeAidesAuLogement(
        input,
      )->Float.toString
    <>
      <span className="font-mono font-bold text-[var(--text-active-blue-france)]">
        {React.string(res)}
      </span>
      {React.string(` €`)}
    </>
  },
}
