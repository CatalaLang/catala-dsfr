@react.component
let make = (~assetsVersion, ~frenchLawVersion=CatalaFrenchLaw.Versions.latest) => {
  // TODO: factorize with AllocationsLogement
  let (frenchLaw, setFrenchLaw) = React.useState(_ => None)

  React.useEffect1(() => {
    CatalaFrenchLaw.get(frenchLawVersion)()
    ->Promise.thenResolve(frenchLaw => {
      setFrenchLaw(_ => Some(frenchLaw))
      None
    })
    ->Promise.done
    None
  }, [frenchLawVersion])

  React.useEffect1(() => {
    // Reset the log when the page is loaded.
    switch frenchLaw {
    | Some({resetLog}) => resetLog()
    | None => ()
    }
    None
  }, [frenchLaw])

  <div className="fr-container">
    <PageComponents.Title> {"Calcul des aides au logement"->React.string} </PageComponents.Title>
    {switch frenchLaw {
    | Some(frenchLaw) => <Form assetsVersion frenchLaw formInfos={AidesLogementUtils.formInfos} />
    | None => Spinners.loader
    }}
  </div>
}
