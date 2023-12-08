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
let make = (~htmlImport: unit => promise<string>, ~simulatorUrl: string) => {
  let {hash} = Nav.getCurrentURL()
  let (htmlState, setHtmlState) = React.useState(_ => None)

  React.useEffect2(() => {
    htmlImport()
    ->Promise.thenResolve(html => {
      setHtmlState(_ => Some(html))
    })
    ->Promise.done
    None
  }, (htmlImport, setHtmlState))

  <div className="fr-container">
    <Button.RightAlign
      props={
        iconId: "fr-icon-equalizer-line",
        iconPosition: "left",
        priority: "tertiary",
        size: "medium",
        onClick: {_ => Nav.goTo(`/${simulatorUrl}`)},
        children: {React.string("Accéder au simulateur")},
      }
    />
    {switch htmlState {
    | Some(html) =>
      <React.Suspense fallback={Spinners.loader}>
        <HtmlSourceCodeLazy html hash />
      </React.Suspense>
    | None => Spinners.loader
    }}
  </div>
}
