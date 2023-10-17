%%raw(`import  "../css/catala-code.css"`)
%%raw(`import  "../css/syntax-highlighting.css"`)

@react.component
let make = (~html: option<string>, ~simulatorUrl: string) => {
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
