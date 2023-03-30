@react.component
let make = () => {
  <Dsfr.Header
    brandTop={<> {`République`->React.string} <br /> {`Française`->React.string} </>}
    homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
    operatorLogo={{"alt": "Catala logo", "imgUrl": "../assets/logo.png", "orientation": "vertical"}}
    serviceTitle="Catala"
    serviceTagline="Simulateurs des aides sociales"
  />
}
