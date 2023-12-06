@react.component
let make = (~formInfos: FormInfos.t, ~version=Versions.latest) => {
  let (frenchLaw, setFrenchLaw) = React.useState(_ => None)

  Console.log2("version", version["name"])

  React.useEffect1(() => {
    FrenchLaw.get(version["french-law"])()
    ->Promise.thenResolve(frenchLaw => {
      setFrenchLaw(_ => Some(frenchLaw))
      None
    })
    ->Promise.done
    None
  }, [version])

  React.useEffect1(() => {
    // Reset the log when the page is loaded.
    switch frenchLaw {
    | Some({resetLog}) => resetLog()
    | None => ()
    }
    None
  }, [frenchLaw])

  <div className="fr-container">
    <h1 className="fr-h1"> {`Calcul des ${formInfos.name}`->React.string} </h1>
    {switch frenchLaw {
    | Some(frenchLaw) =>
      <Form assetsVersion={version["catala-web-assets"]} frenchLaw formInfos={formInfos} />
    | None => Spinners.loader
    }}
  </div>
}
