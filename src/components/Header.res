@react.component
let make = () => {
  <Dsfr.Header
    brandTop={<>
      {`République`->React.string}
      <br />
      {`Française`->React.string}
    </>}
    homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
    /* operatorLogo={{"alt": "Catala logo", "imgUrl": "../assets/logo.png", "orientation": "vertical"}} */
    serviceTitle={<>
      {"Explicabilité des algorithmes publics"->React.string}
      <Dsfr.Badge noIcon=true severity={#success} as_=#span small=false>
        {"beta"->React.string}
      </Dsfr.Badge>
    </>}
    serviceTagline="Prototypes de simulateurs de prestations sociales avec explications invidualisées, détaillées et intelligibles"
  />
}
