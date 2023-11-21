%%raw(`import  "../css/catala-code.css"`)
%%raw(`import  "../css/syntax-highlighting.css"`)

/*
[scrollToAndHighlightLineNum(parentElem, ids)] scrolls into the corresponding
Catala code line of [ids] inside the [parentElem] DOM element and highlight the
line numbers.
*/

module HtmlSourceCodeLazy = {
  @react.component @module("../components/HtmlSourceCodeLazy.tsx")
  external make: (~html: string, ~hash: string) => React.element = "default"
}

@react.component
let make = (~version: string, ~htmlImport: Vite.getPromise<string>, ~simulatorUrl: string) => {
  let {hash, path: currentPath} = Nav.getCurrentURL()
  let (htmlState, setHtmlState) = React.useState(_ => None)

  React.useEffect1(() => {
    htmlImport()
    ->Promise.thenResolve(html => {
      setHtmlState(_ => Some(html))
    })
    ->Promise.done
    None
  }, [htmlImport])

  let versionedAssetsButtons = WebAssets.Versions.available->Array.map(v => {
    Dsfr.Button.children: {React.string(v)},
    onClick: {
      _ => {
        switch currentPath {
        | list{page, "sources"}
        | list{page, "sources", _} =>
          if v != version {
            Nav.goToAbsolutePath(list{page, "sources", v})
          }
        | _ =>
          Js.Exn.raiseError("Unexpected path: " ++ currentPath->List.toArray->Array.joinWith("/"))
        }
      }
    },
    priority: "secondary",
    size: "small",
    iconId: if v == version {
      "fr-icon-success-fill"
    } else {
      ""
    },
  })

  <div className="fr-container">
    <Dsfr.ButtonsGroup
      inlineLayoutWhen="always"
      buttonsEquisized=true
      buttonsSize="small"
      buttons={versionedAssetsButtons}
    />
    <Button.RightAlign
      props={
        iconId: "fr-icon-equalizer-line",
        iconPosition: "left",
        priority: "tertiary",
        size: "medium",
        onClick: {_ => `/${simulatorUrl}`->Nav.goTo},
        children: {"Accéder au simulateur"->React.string},
      }
    />
    {switch htmlState {
    | Some(html) =>
      Console.log2("hash", hash)

      <React.Suspense fallback={Spinners.loader}>
        <HtmlSourceCodeLazy html hash />
      </React.Suspense>
    | None => Spinners.loader
    }}
  </div>
}
