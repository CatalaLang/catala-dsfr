let alURL = AidesLogementUtils.formInfos.url
let afURL = AllocationsFamilialesUtils.formInfos.url

@react.component
let make = () => {
  switch Nav.getCurrentURL().path {
  | list{route} if route == afURL =>
    <AllocationsFamiliales assetsVersion={WebAssets.Versions.latest} />
  | list{route} if route == alURL => <AidesLogement assetsVersion={WebAssets.Versions.latest} />
  | list{route, "sources"} if route == afURL =>
    <SourceCode
      version={WebAssets.Versions.latest}
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={afURL}
    />
  | list{route, "sources", "debug"} if route == alURL =>
    <SourceCode
      version={WebAssets.Versions.latest}
      htmlImport={WebAssets.getAidesLogementSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={alURL}
    />
  | list{route, "sources", version}
    if WebAssets.Versions.available->Array.includes(version) && route == afURL =>
    <SourceCode
      version
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(version)}
      simulatorUrl={afURL}
    />
  | list{route, "sources", version}
    if WebAssets.Versions.available->Array.includes(version) && route == alURL =>
    <SourceCode
      version htmlImport={WebAssets.getAidesLogementSourceCode(version)} simulatorUrl={alURL}
    />
  | _ => <Home />
  }
}
