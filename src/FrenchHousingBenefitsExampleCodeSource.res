%raw(`import("./css/catala-code.css")`)

@react.component
let make = () => {
  <div className="fr-container">
    // <PageComponents.Title>
    //   {`Code source des aides aux logements`->React.string}
    // </PageComponents.Title>
    {switch WebAssets.frenchHousingAssets.html {
    | Some(html) => <CatalaCode.DangerouslySetInnerHtml html />
    | None => <p> {`Le code source n'est pas disponible pour le moment.`->React.string} </p>
    }}
  </div>
}
