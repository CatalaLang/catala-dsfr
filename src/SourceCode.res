%%raw(`import  "./css/catala_code.css"`)

@react.component
let make = (~html: option<string>, ~source) => {
  switch html {
  | Some(html) =>
    <div
      className="fr-container catala-code"
      dangerouslySetInnerHTML={
        "__html": html,
      }
    />
  | None =>
    ()
    <div>
      <p> {"No source code available for this snippet."->React.string} </p>
    </div>
  }
}
