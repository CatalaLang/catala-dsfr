@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{route} if route == AllocationsFamiliales.url => <AllocationsFamiliales />
  | list{route} if route == AidesLogement.url => <AidesLogement />
  | list{route, "sources"} if route == AllocationsFamiliales.url =>
    <SourceCode
      html={WebAssets.alloactionsFamilialesAssets.html} simulatorUrl={AllocationsFamiliales.url}
    />
  | list{route, "sources"} if route == AidesLogement.url =>
    <SourceCode html={WebAssets.aidesLogementAssets.html} simulatorUrl={AidesLogement.url} />
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
