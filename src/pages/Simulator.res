@react.component
let make = (~formInfos: FormInfos.t, ~version=Versions.latest) => {
  let {path: currentPath} = Nav.getCurrentURL()
  let (frenchLaw, setFrenchLaw) = React.useState(_ => None)

  React.useEffect2(() => {
    FrenchLaw.get(version["french-law"])()
    ->Promise.thenResolve(frenchLaw => {
      setFrenchLaw(_ => Some(frenchLaw))
    })
    ->Promise.done
    None
  }, (version["french-law"], setFrenchLaw))

  React.useEffect1(() => {
    // Reset the log when the page is loaded.
    switch frenchLaw {
    | Some({resetLog}) => resetLog()
    | None => ()
    }
    None
  }, [frenchLaw])

  let versionedAssetsButtons = Versions.available->Array.map(v => {
    DSFR.Button.children: {React.string(v["name"])},
    onClick: {
      _ => {
        switch currentPath {
        | list{page}
        | list{page, _} =>
          if v["name"] != version["name"] {
            Nav.goToAbsolutePath(list{page, v["name"]})
          }
        | _ =>
          Js.Exn.raiseError("Unexpected path: " ++ currentPath->List.toArray->Array.joinWith("/"))
        }
      }
    },
    priority: "secondary",
    size: "small",
    iconId: if v["name"] == version["name"] {
      "fr-icon-success-fill"
    } else {
      ""
    },
  })

  <div className="fr-container">
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
