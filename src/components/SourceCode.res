%%raw(`import  "../css/catala-code.css"`)
%%raw(`import  "../css/syntax-highlighting.css"`)
%%raw(`import scrollAndHighlightLine from '../utils/scrollAndHightlightLine.ts'`)

/*
[scrollToAndHighlightLineNum(parentElem, ids)] scrolls into the corresponding
Catala code line of [ids] inside the [parentElem] DOM element and highlight the
line numbers.
*/

external scrollToAndHighlightLineNum: (Dom.element, string) => unit = "scrollAndHighlightLine"

@react.component
let make = (~html: option<string>, ~simulatorUrl: string) => {
  let {hash} = RescriptReactRouter.useUrl()

  let parentDomElemRef = React.useRef(Js.Nullable.null)
  React.useEffect1(() => {
    switch (parentDomElemRef.current->Js.Nullable.toOption, hash) {
    | (Some(parentDomElem), ids) if ids != "" => scrollToAndHighlightLineNum(parentDomElem, ids)
    | _ => ()
    }
    None
  }, [hash])

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
      <div
        className="catala-code"
        ref={ReactDOM.Ref.domRef(parentDomElemRef)}
        dangerouslySetInnerHTML={
          "__html": html,
        }
      />
    </div>
  | None =>
    ()
    <div>
      <p> {"No source code available for this snippet."->React.string} </p>
    </div>
  }
}
