open DSFR

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
    let isCurrentVersion = v["name"] == version["name"]
    {
      Button.children: {React.string(v["name"])},
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

  <div className={Fr.cx([#"fr-container", #"fr-pt-6v"])}>
    <Accordion label={React.string("Versions disponibles")}>
      <ButtonsGroup
        className={Fr.cx([#"fr-pt-4v", #"fr-pb-0"])}
        inlineLayoutWhen=#always
        buttonsEquisized=true
        buttonsSize=#medium
        buttons={versionedAssetsButtons}
      />
    </Accordion>
    <h1 className={Fr.cx([#"fr-h1", #"fr-pt-6v"])}>
      {React.string(`Calcul des ${formInfos.name}`)}
    </h1>
    {switch frenchLaw {
    | Some(frenchLaw) => <Form version frenchLaw formInfos={formInfos} />
    | None => Spinners.loader
    }}
  </div>
}
