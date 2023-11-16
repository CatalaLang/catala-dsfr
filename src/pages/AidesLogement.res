@react.component
let make = (~assetsVersion: string) => {
  React.useEffect(() => {
    // Reset the log when the page is loaded.
    CatalaFrenchLaw.resetLog()
    None
  })

  <div className="fr-container">
    <PageComponents.Title> {"Calcul des aides au logement"->React.string} </PageComponents.Title>
    <Form assetsVersion formInfos={AidesLogementUtils.formInfos} />
  </div>
}
