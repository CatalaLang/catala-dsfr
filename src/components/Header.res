%%raw(`import logoURL from "../images/logo.png"`)

external logo: string = "logoURL"

@react.component
let make = () => {
  <DSFR.Header
    brandTop={<>
      {React.string("République")}
      <br />
      {React.string("Française")}
    </>}
    operatorLogo={{
      "alt": "Catala logo",
      "imgUrl": logo,
      "orientation": #vertical,
    }}
    homeLinkProps={{"href": "/", "title": "Catala Explorer"}}
    serviceTitle={<>
      {React.string("Explicabilité des algorithmes publics")}
      <DSFR.Badge noIcon=true severity={#success} as_=#span small=false>
        {React.string("beta")}
      </DSFR.Badge>
    </>}
    serviceTagline="Prototypes de simulateurs de prestations sociales avec explications invidualisées, détaillées et intelligibles"
  />
}
