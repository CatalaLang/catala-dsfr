@react.component
let make = () => {
  <Dsfr.Footer
    accessibility="partially compliant"
    brandTop={<>
      {`République`->React.string}
      <br />
      {`Française`->React.string}
    </>}
    contentDescription={<>
      {`Ce site est développé dans le cadre de la `->React.string}
      <a href="https://www.code.gouv.fr" target="_blank">
        {`mission logiciels libres et communs numériques`->React.string}
      </a>
      {` de la `->React.string}
      <a href="https://www.numerique.gouv.fr/" target="_blank">
        {`direction interministérielle du numérique`->React.string}
      </a>
      {` en collaboration avec le projet `->React.string}
      <a href="https://catala-lang.org/" target="_blank"> {`Catala`->React.string} </a>
      {`, avec l'objectif de tester des solutions techniques de conformité à l'`->React.string}
      <a href="https://www.legifrance.gouv.fr/loda/article_lc/LEGIARTI000037823131" target="_blank">
        {`article 47-2 de la loi informatique et libertés`->React.string}
      </a>
    </>}
    homeLinkProps={"href": "https://www.code.gouv.fr", "title": "Code du travail numérique"}
    license={<>
      {`Sauf mention contraire, tout le contenu de ce site est sous licence `->React.string}
      <a href="https://github.com/CatalaLang/catala-explorer/blob/main/LICENSE">
        {`Apache 2.0`->React.string}
      </a>
    </>}
    bottomItems=[
      {
        "text": {`Code source du site`->React.string},
        "linkProps": {"href": "https://github.com/catalalang/catala-dsfr"},
      },
      Dsfr.Display.headerFooterDisplayItem,
    ]
  />
}
