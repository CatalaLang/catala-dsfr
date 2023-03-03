module HeaderDSFR = {
  @react.component @module("@codegouvfr/react-dsfr/Header")
  external make: (
    ~brandTop: React.element=?,
    ~homeLinkProps: {"href": string, "title": string},
    ~serviceTagline: string,
    ~operatorLogo: {"alt": string, "imgUrl": string, "orientation": string}=?,
    ~serviceTitle: string,
  ) => React.element = "default"
}

@react.component
let make = () => {
  <HeaderDSFR
    brandTop={<> {`République`->React.string} <br /> {`Française`->React.string} </>}
    homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
    operatorLogo={{"alt": "Catala logo", "imgUrl": "../assets/logo.png", "orientation": "vertical"}}
    serviceTitle="Catala"
    serviceTagline="Simulateurs des aides sociales"
  />
}
