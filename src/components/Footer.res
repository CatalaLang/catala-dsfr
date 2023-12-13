@react.component
let make = () => {
  <DSFR.Footer
    accessibility="partially compliant"
    brandTop={<>
      {React.string("République")}
      <br />
      {React.string("Française")}
    </>}
    contentDescription={<>
      {React.string("Ce site est développé dans le cadre de la ")}
      <a href="https://code.gouv.fr/" target="_blank">
        {React.string("mission logiciels libres et communs numériques")}
      </a>
      {React.string(" de la ")}
      <a href="https://www.numerique.gouv.fr/" target="_blank">
        {React.string("direction interministérielle du numérique")}
      </a>
      {React.string(" en collaboration avec le projet ")}
      <a href="https://catala-lang.org/" target="_blank"> {React.string("Catala")} </a>
      {React.string(", avec l'objectif de tester des solutions techniques de conformité à l'")}
      <a href="https://www.legifrance.gouv.fr/loda/article_lc/LEGIARTI000037823131" target="_blank">
        {React.string("article 47-2 de la loi informatique et libertés")}
      </a>
    </>}
    homeLinkProps={"href": "https://www.code.gouv.fr", "title": "Code du travail numérique"}
    license={<>
      {React.string("Sauf mention contraire, tout le contenu de ce site est sous licence ")}
      <a href="https://github.com/CatalaLang/catala-explorer/blob/main/LICENSE">
        {React.string("Apache 2.0")}
      </a>
    </>}
    bottomItems=[
      {
        "text": {React.string("Code source du site")},
        "linkProps": {"href": "https://github.com/catalalang/catala-dsfr"},
      },
      DSFR.Display.headerFooterDisplayItem,
    ]
  />
}
