@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  Js.log(url)

  switch url.path {
  | list{"french-family-benefits"} => <FrenchFamilyBenefitsExample.Visualizer />
  | list{"french-housing-benefits"} => <FrenchHousingBenefitsExample.Visualizer />
  | list{} => <Home />
  | _ => <Home />
  }
}
