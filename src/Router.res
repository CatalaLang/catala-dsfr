module AL = AidesLogement
module AF = AllocationsFamiliales

@react.component
let make = () => {
  switch Nav.getCurrentURL().path {
  | list{} => <Home />
  | list{route} if route == AF.infos.url => <Simulator formInfos={AF.infos} />
  | list{route, versionName} if route == AF.infos.url && Versions.isAvailable(versionName) =>
    <Simulator formInfos={AF.infos} version={Versions.getUnsafe(versionName)} />
  | list{route} if route == AL.infos.url => <Simulator formInfos={AL.infos} />
  | list{route, versionName} if route == AL.infos.url && Versions.isAvailable(versionName) =>
    <Simulator formInfos={AL.infos} version={Versions.getUnsafe(versionName)} />
  | list{route, "sources"} if route == AF.infos.url =>
    <SourceCode
      version={WebAssets.Versions.latest}
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(WebAssets.Versions.latest)}
      simulatorUrl={AF.infos.url}
    />
  | list{route, "sources", version}
    if route == AF.infos.url && WebAssets.Versions.available->Array.includes(version) =>
    <SourceCode
      version
      htmlImport={WebAssets.getAllocationsFamilialesSourceCode(version)}
      simulatorUrl={AF.infos.url}
    />
  | list{route, "sources", version}
    if route == AL.infos.url && WebAssets.Versions.available->Array.includes(version) =>
    <SourceCode
      version htmlImport={WebAssets.getAidesLogementSourceCode(version)} simulatorUrl={AL.infos.url}
    />
  | _ => <Page404 />
  }
}
