module AF = AllocationsFamiliales
module AL = AidesLogement

@react.component
let make = () => {
  switch Nav.getCurrentURL().path {
  | list{route} if route == AF.FormInfos.url => <AllocationsFamiliales />
  | list{route} if route == AL.FormInfos.url => <AidesLogement />
  | list{route, "sources"} if route == AF.FormInfos.url =>
    <SourceCode
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={AF.FormInfos.url}
    />
  | list{route, "sources"} if route == AL.FormInfos.url =>
    <SourceCode
      htmlImport={WebAssets.getAidesLogementSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={AL.FormInfos.url}
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
