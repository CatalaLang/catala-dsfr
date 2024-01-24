@react.component
let make = () => {
  <>
    <DSFR.Notice
      title={<>
        {React.string("Les simulateurs présentés sur ce site Internet ne prétendent pas à remplacer les simulateurs
    officiels des administrations et opérateurs de l'État compétents. Aussi, les résultats
    qu'ils retournent peuvent être entâchés d'erreurs. Cependant, et c'est l'objectif de ces prototypes, le résultat
    qu'ils affichent peut-être expliqué pas-à-pas en faisant référence aux règles de droit qui spécifient le calcul.
    Aussi, si vous trouvez une erreur, n'hésitez pas à nous en faire part en créant ")}
        <a href="https://github.com/CatalaLang/catala-dsfr/issues" target="_blank">
          {React.string("un ticket")}
        </a>
        {React.string(".")}
      </>}
    />
    <div className="fr-container-fluid bg-background">
      <div className="fr-container">
        <div className="fr-grid-row fr-grid-row--gutters">
          <div className="fr-col-lg-6 fr-col-offset-lg-1">
            <h1 className="fr-h1 fr-mt-3w fr-mt-md-5w fr-mb-5w">
              {React.string(
                "Calculer et fournir une explication détaillée de façon automatique",
              )}
            </h1>
            <div className="fr-mb-3w">
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
                {React.string(
                  ", avec l'objectif de tester des solutions techniques de conformité à l'",
                )}
                <a
                  href="https://www.legifrance.gouv.fr/loda/article_lc/LEGIARTI000037823131"
                  target="_blank">
                  {React.string("article 47-2 de la loi informatique et libertés")}
                </a>
                {React.string(".")}
              </p>
              <p>
                <br />
                {React.string(
                  "Le contexte d'élaboration de ce prototype et les enjeux de l'explicabilité des algorithmes \
      publics sont détaillés dans un rapport de recherche de l'INRIA dont nous encourageons fortement la lecture.",
                )}
              </p>
            </div>
            <p className="fr-mb-5w">
              <a
                className="fr-btn fr-btn--secondary"
                href="https://inria.hal.science/hal-04391612"
                target="_blank">
                {React.string("Consulter le rapport de recherche")}
              </a>
            </p>
          </div>
          <div className="fr-col-12 fr-col-lg-4 fr-pl-0 fr-pl-md-4w fr-pb-0 sm:block hidden">
            <figure id="content-media__homepage-banner" role="group" className="fr-content-media">
              <div className="fr-content-media__img ">
                <img src={%raw(`require("../images/hero.png")`)} className="" />
              </div>
            </figure>
          </div>
        </div>
      </div>
    </div>
    <div className="fr-container pt-16 pb-10">
      <h2 className="fr-h2"> {React.string("Simulateurs disponibles")} </h2>
      <div className="fr-grid-row fr-grid-row--gutters">
        <div className="fr-col-sm-12 fr-col-lg-6">
          <DSFR.Card
            title={React.string("Allocations Familiales")}
            desc={React.string("Simulateur du calcul des allocations familiales")}
            linkProps={
              href: "/" ++ AllocationsFamiliales.infos.url,
              title: React.string("Allocations Familiales"),
            }
            enlargeLink=true
            size=#large
          />
        </div>
        <div className="fr-col-sm-12 fr-col-lg-6">
          <DSFR.Card
            title={React.string("Aides aux Logements")}
            desc={React.string("Simulateur du calcul des aides aux logements")}
            linkProps={
              href: "/" ++ AidesLogement.infos.url,
              title: React.string("Aides Logements"),
            }
            enlargeLink=true
            size=#large
          />
        </div>
      </div>
    </div>
  </>
}
