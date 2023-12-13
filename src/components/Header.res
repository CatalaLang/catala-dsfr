@react.component
let make = () => {
  <DSFR.Header
    brandTop={<>
      {React.string("République")}
      <br />
      {React.string("Française")}
    </>}
    homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
    /* operatorLogo={{"alt": "Catala logo", "imgUrl": "../assets/logo.png", "orientation": "vertical"}} */
    serviceTitle={<>
      {React.string("Explicabilité des algorithmes publics")}
      <DSFR.Badge noIcon=true severity={#success} as_=#span small=false>
        {React.string("beta")}
      </DSFR.Badge>
    </>}
    serviceTagline="Prototypes de simulateurs de prestations sociales avec explications invidualisées, détaillées et intelligibles"
  />
}
