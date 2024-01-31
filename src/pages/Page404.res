open DSFR

@react.component
let make = () => {
  <div className={Fr.cx([#"fr-container"])}>
    <h1 className={Fr.cx([#"fr-h1"])}> {React.string("Page non trouvée")} </h1>
    <p className={Fr.cx([#"fr-text--sm", #"fr-mb-3w"])}> {React.string("Erreur 404")} </p>
    <p className={Fr.cx([#"fr-text--lead", #"fr-mb-3w"])}>
      {React.string("La page que vous cherchez est introuvable. Excusez-nous pour la gène
            occasionnée.")}
    </p>
    <p className={Fr.cx([#"fr-text--sm", #"fr-mb-5w"])}>
      {React.string("Si vous avez tapé l'adresse web dans le navigateur, vérifiez qu'elle
            est correcte. La page n’est peut-être plus disponible.")}
      <br />
      {React.string("Dans ce cas, pour continuer votre visite vous pouvez consulter notre
            page d’accueil, ou effectuer une recherche avec notre moteur de
            recherche en haut de page.")}
      <br />
      {React.string("Sinon contactez-nous pour que l’on puisse vous rediriger vers la
            bonne information.")}
    </p>
    <ul className={Fr.cx([#"fr-btns-group", #"fr-btns-group--inline-md"])}>
      <li>
        <a className={Fr.cx([#"fr-btn"])} href=Constants.baseURL>
          {React.string("Page d'accueil")}
        </a>
      </li>
    </ul>
  </div>
}
