@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"french-family-benefits"} => <FrenchFamilyBenefitsExample />
  | list{"french-housing-benefits"} => <FrenchHousingBenefitsExample />
  | list{"sources", "french-family-benefits"} => <FrenchHousingBenefitsExampleCodeSource />
  | list{"sources", "french-housing-benefits"} => <FrenchHousingBenefitsExampleCodeSource />

  | list{} => <Home />
  | _ => <Home />
  }
}

module Link = {
  @react.component
  let make = (~href: string, ~children) => {
    <a
      href={href}
      onClick={evt => {
        evt->ReactEvent.Mouse.preventDefault
        href->RescriptReactRouter.push
      }}>
      children
    </a>
  }
}
