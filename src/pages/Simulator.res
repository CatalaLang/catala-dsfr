@react.component
let make = (~formInfos: FormInfos.t, ~version=Versions.latest) => {
  let {path: currentPath} = Nav.getCurrentURL()
  let (frenchLaw, setFrenchLaw) = React.useState(_ => None)

  React.useEffect(() => {
    FrenchLaw.get(version["french-law"])()
    ->Promise.thenResolve(frenchLaw => {
      setFrenchLaw(_ => Some(frenchLaw))
    })
    ->Promise.done
    None
  }, (version["french-law"], setFrenchLaw))

  React.useEffect(() => {
    // Reset the log when the page is loaded.
    switch frenchLaw {
    | Some({resetLog}) => resetLog()
    | None => ()
    }
    None
  }, [frenchLaw])

  let versionedAssetsButtons = Versions.available->Array.map(v => {
    let isCurrentVersion = v["name"] == version["name"]
    {
      DSFR.Button.children: {React.string(v["name"])},
      onClick: {
        _ => {
          switch currentPath {
          | list{page}
          | list{page, _} =>
            if !isCurrentVersion {
              Nav.goToAbsolutePath(list{page, v["name"]})
            }
          | _ =>
            Js.Exn.raiseError("Unexpected path: " ++ currentPath->List.toArray->Array.joinWith("/"))
          }
        }
      },
      priority: isCurrentVersion ? #secondary : #tertiary,
      size: #small,
      // FIXME: this icon can't be correctly rendered in production, I really don't know why...
      // iconId: isCurrentVersion ? "fr-icon-success-fill" : "",
    }
  })

  <div className="fr-container pt-6">
    <DSFR.Accordion label="Versions disponibles">
      <DSFR.ButtonsGroup
        className="pt-4 pb-0"
        inlineLayoutWhen=#always
        buttonsEquisized=true
        buttonsSize=#medium
        buttons={versionedAssetsButtons}
      />
    </DSFR.Accordion>
    <h1 className="fr-h1 pt-6"> {React.string(`Calcul des ${formInfos.name}`)} </h1>
    {switch frenchLaw {
    | Some(frenchLaw) => <Form version frenchLaw formInfos={formInfos} />
    | None => Spinners.loader
    }}
  </div>
}
