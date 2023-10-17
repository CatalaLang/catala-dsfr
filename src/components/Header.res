@react.component
let make = () => {
  <div>
    <Dsfr.Header
      brandTop={<>
        {`République`->React.string}
        <br />
        {`Française`->React.string}
      </>}
      homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
      /* operatorLogo={{"alt": "Catala logo", "imgUrl": "../assets/logo.png", "orientation": "vertical"}} */
      serviceTitle="Explicabilité des algorithmes publics"
      serviceTagline="Prototypes de simulateurs de prestations sociales avec explications invidualisées, détaillées et intelligibles"
    />
  </div>
}
