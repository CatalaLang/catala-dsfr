@react.component
let make = () => {
  <div className="fr-container">
    <div className="fr-grid-row fr-grid-row--gutters fr-grid-row--center fr-grid-row--middle">
      <div className="fr-col fr-col-lg-8">
        <Dsfr.Card
          title="Allocations Familiales"
          desc="Simulateur du calcul des allocations familiales"
          linkProps={
            "href": AllocationsFamiliales.infos.url,
            "title": "Allocations Familiales",
          }
          enlargeLink=true
          size="large"
        />
        <Dsfr.Card
          title="Aides aux Logements"
          desc="Simulateur du calcul des aides aux logements"
          linkProps={
            "href": AidesLogement.infos.url,
            "title": "Aides Logements",
          }
          enlargeLink=true
          size="large"
        />
      </div>
    </div>
  </div>
}
