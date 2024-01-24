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
    operatorLogo={
      alt: "Catala logo",
      imgUrl: logo,
      orientation: #vertical,
    }
    homeLinkProps={{href: "/", title: React.string("Catala Explorer")}}
    serviceTitle={<>
      {React.string("Explicabilité des algorithmes publics")}
      <DSFR.Badge noIcon=true severity={#info} as_=#span> {React.string("prototype")} </DSFR.Badge>
    </>}
    serviceTagline={React.string(
      "Prototypes de simulateurs de prestations sociales avec explications invidualisées, détaillées et intelligibles",
    )}
  />
}
