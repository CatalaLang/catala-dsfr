@react.component
let make = () => {
  <div className="fr-container">
    <h2 className="fr-h2 pt-6"> {React.string("À propos")} </h2>
    <p>
      {React.string("Ce site présente un prototype développé dans le cadre de la ")}
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
      {React.string(
        ". Le contexte d'élaboration de ce prototype et les enjeux de l'explicabilité des algorithmes \
      publics sont détaillés dans un ",
      )}
      <a href="https://inria.hal.science/hal-04391612" target="_blank">
        {React.string("rapport de recherche de l'INRIA")}
      </a>
      {React.string(" dont nous encourageons fortement la lecture.")}
    </p>
    <br />
    <p>
      {React.string("Les simulateurs présentés sur ce site Internet ne prétendent pas à remplacer les simulateurs
    officiels des administrations et opérateurs de l'État compétents. Aussi, les résultats
    qu'ils retournent peuvent être entâchés d'erreurs. Cependant, et c'est l'objectif de ces prototypes, le résultat
    qu'ils affichent peut-être expliqué pas-à-pas en faisant référence aux règles de droit qui spécifient le calcul.
    Aussi, si vous trouvez une erreur, n'hésitez pas à nous en faire part en créant ")}
      <a href="https://github.com/CatalaLang/catala-dsfr/issues" target="_blank">
        {React.string("un ticket")}
      </a>
      {React.string(".")}
    </p>
    <h2 className="fr-h2 pt-6"> {React.string("Simulateurs disponibles")} </h2>
    <div className="fr-grid-row fr-grid-row--gutters fr-grid-row--center fr-grid-row--middle">
      <div className="fr-col fr-col-lg-8">
        <DSFR.Card
          title="Allocations Familiales"
          desc="Simulateur du calcul des allocations familiales"
          linkProps={
            "href": "/" ++ AllocationsFamiliales.infos.url,
            "title": "Allocations Familiales",
          }
          enlargeLink=true
          size="large"
        />
        <DSFR.Card
          title="Aides aux Logements"
          desc="Simulateur du calcul des aides aux logements"
          linkProps={
            "href": "/" ++ AidesLogement.infos.url,
            "title": "Aides Logements",
          }
          enlargeLink=true
          size="large"
        />
      </div>
    </div>
  </div>
}
