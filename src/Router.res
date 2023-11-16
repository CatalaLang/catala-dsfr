module AF = AllocationsFamiliales
module AL = AidesLogement

@react.component
let make = () => {
  switch Nav.getCurrentURL().path {
  | list{route} if route == AF.FormInfos.url =>
    <AllocationsFamiliales assetsVersion={WebAssets.Versions.latest} />
  | list{route} if route == AL.FormInfos.url =>
    <AidesLogement assetsVersion={WebAssets.Versions.latest} />
  | list{route, "sources"} if route == AF.FormInfos.url =>
    <SourceCode
      version={WebAssets.Versions.latest}
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={AF.FormInfos.url}
    />
  | list{route, "sources", "debug"} if route == AL.FormInfos.url =>
    <SourceCode
      version={WebAssets.Versions.latest}
      htmlImport={WebAssets.getAidesLogementSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={AL.FormInfos.url}
    />
  | list{route, "sources", version}
    if WebAssets.Versions.available->Array.includes(version) && route == AF.FormInfos.url =>
    <SourceCode
      version
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(version)}
      simulatorUrl={AF.FormInfos.url}
    />
  | list{route, "sources", version}
    if WebAssets.Versions.available->Array.includes(version) && route == AL.FormInfos.url =>
    <SourceCode
      version
      htmlImport={WebAssets.getAidesLogementSourceCode(version)}
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
