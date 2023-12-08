@react.component
let make = () => {
  <Dsfr.Header
    brandTop={<>
      {React.string("République")}
      <br />
      {React.string("Française")}
    </>}
    homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
    /* operatorLogo={{"alt": "Catala logo", "imgUrl": "../assets/logo.png", "orientation": "vertical"}} */
    serviceTitle={<>
      {React.string("Explicabilité des algorithmes publics")}
      <Dsfr.Badge noIcon=true severity={#success} as_=#span small=false>
        {React.string("beta")}
      </Dsfr.Badge>
    </>}
    serviceTagline="Prototypes de simulateurs de prestations sociales avec explications invidualisées, détaillées et intelligibles"
  />
}
