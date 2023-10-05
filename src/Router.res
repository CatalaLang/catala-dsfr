@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"allocations-familiales"} => <FrenchFamilyBenefitsExample />
  | list{"aides-logement"} => <FrenchHousingBenefitsExample />
  | list{"allocations-familiales", "sources", source} =>
    <SourceCode html={WebAssets.frenchFamilyAssets.html} source />
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
