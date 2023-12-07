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
  | list{route, "sources"} if route == AF.infos.url => {
      let version = Versions.latest["catala-web-assets"]
      <SourceCode
        htmlImport={WebAssets.getAllocationsFamilialesSourceCode(version)}
        simulatorUrl={AF.infos.url}
      />
    }
  | list{route, versionName, "sources"}
    if route == AF.infos.url && Versions.isAvailable(versionName) => {
      let version = Versions.getUnsafe(versionName)["catala-web-assets"]
      <SourceCode
        htmlImport={WebAssets.getAllocationsFamilialesSourceCode(version)}
        simulatorUrl={AF.infos.url}
      />
    }
  | list{route, versionName, "sources"}
    if route == AL.infos.url && Versions.isAvailable(versionName) => {
      let version = Versions.getUnsafe(versionName)["catala-web-assets"]
      <SourceCode
        htmlImport={WebAssets.getAidesLogementSourceCode(version)} simulatorUrl={AL.infos.url}
      />
    }
  | _ => <Page404 />
  }
}
