@react.component
let make = () => {
  <div className="fr-container">
    <div className="fr-grid-row fr-grid-row--gutters fr-grid-row--center fr-grid-row--middle">
      <div className="fr-col fr-col-lg-8 ">
        <Card.Dsfr
          title="Allocations Familiales"
          desc="Simulateur du calcul des allocations familiales"
          linkProps={"href": "/french-family-benefits"}
          enlargeLink=true
          size="large"
        />
        <Card.Dsfr
          title="Aides Logements"
          desc="Simulateur du calcul des aides aux logements"
          linkProps={"href": "/french-housing-benefits"}
          enlargeLink=true
          size="large"
        />
      </div>
    </div>
  </div>
}