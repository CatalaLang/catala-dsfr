@react.component
let make = (~assetsVersion: string) => {
  React.useEffect0(() => {
    // Reset the log when the page is loaded.
    CatalaFrenchLaw.resetLog()
    None
  })

  <div className="fr-container">
    <PageComponents.Title>
      {"Calcul des allocations familiales"->React.string}
    </PageComponents.Title>
    <Form assetsVersion formInfos={AllocationsFamilialesUtils.formInfos} />
  </div>
}
