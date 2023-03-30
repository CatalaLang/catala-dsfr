@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"french-family-benefits"} => <FrenchFamilyBenefitsExample />
  | list{"french-housing-benefits"} => <FrenchHousingBenefitsExample />
  | list{} => <Home />
  | _ => <Home />
  }
}
