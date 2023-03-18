module FooterDSFR = {
  @react.component @module("@codegouvfr/react-dsfr/Footer")
  external make: (
    ~accessibility: string,
    ~brandTop: React.element=?,
    ~contentDescription: React.element=?,
    ~homeLinkProps: {"href": string, "title": string}=?,
    ~license: React.element=?,
  ) => React.element = "default"
}

@react.component
let make = () => {
  <FooterDSFR
    accessibility="partially compliant"
    brandTop={<> {`République`->React.string} <br /> {`Française`->React.string} </>}
    contentDescription={<>
      {"Ce site est développé dans le câdre de la "->React.string}
      <a href="https://www.code.gouv.fr">
        {`mission logiciels libres et communs numériques`->React.string}
      </a>
      {" de la "->React.string}
      <a href="https://www.numerique.gouv.fr/">
        {`direction interministérielle du numérique`->React.string}
      </a>
      {" en collaboration avec le projet "->React.string}
      <a href="https://catala-lang.org/"> {`Catala`->React.string} </a>
      {"."->React.string}
    </>}
    homeLinkProps={"href": "https://www.code.gouv.fr", "title": "Code du travail numérique"}
    license={<>
      {`Sauf mention contraire, tout le contenu de ce site est sous licence `->React.string}
      <a href="https://github.com/CatalaLang/catala-explorer/blob/main/LICENSE">
        {`Apache 2.0`->React.string}
      </a>
    </>}
  />
}
