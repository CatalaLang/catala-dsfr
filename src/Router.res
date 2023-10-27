@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{route} if route == AllocationsFamiliales.FormInfos.url => <AllocationsFamiliales />
  | list{route} if route == AidesLogement.FormInfos.url => <AidesLogement />
  | list{route, "sources"} if route == AllocationsFamiliales.FormInfos.url =>
    <SourceCode
      html={WebAssets.allocationsFamilialesAssets.html}
      simulatorUrl={AllocationsFamiliales.FormInfos.url}
    />
  | list{route, "sources"} if route == AidesLogement.FormInfos.url =>
    <SourceCode
      html={WebAssets.aidesLogementAssets.html} simulatorUrl={AidesLogement.FormInfos.url}
    />
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
        href->Nav.goTo
      }}>
      children
    </a>
  }
}
