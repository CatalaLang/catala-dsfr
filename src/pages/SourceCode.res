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
let make = (~html: option<string>, ~simulatorUrl: string) => {
  let {hash} = RescriptReactRouter.useUrl()

  switch html {
  | Some(html) =>
    <div className="fr-container">
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
      <React.Suspense fallback={Spinners.loader}>
        <HtmlSourceCodeLazy html hash />
      </React.Suspense>
    </div>
  | None =>
    ()
    <div>
      <p> {"No source code available for this snippet."->React.string} </p>
    </div>
  }
}
