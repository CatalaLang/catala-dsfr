@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  Js.log(url)

  switch url.path {
  | list{"french-family-benefits"} => {
      Js.log("DEBUG")
      <FrenchFamilyBenefitsExample.Visualizer />
    }
  | list{} => <Home />
  | _ => <Home />
  }
}
