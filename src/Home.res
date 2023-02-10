@react.component
let make = () => {
  let buttonClassName = "fr-btn"

  <ul className="fr-btns-group fr-btns-group--lg">
    <li>
      <button className=buttonClassName onClick={_ => `/french-family-benefits`->Nav.goTo}>
        {`Allocations Familiales`->React.string}
      </button>
    </li>
    <li>
      <button
        className={buttonClassName ++ " fr-btn--secondary"}
        onClick={_ => `/french-housing-benefits`->Nav.goTo}>
        {`Aides Logements`->React.string}
      </button>
    </li>
  </ul>
}
