module Header = {
  @react.component @module("@codegouvfr/react-dsfr/Header")
  external make: (
    ~brandTop: React.element=?,
    ~homeLinkProps: {"href": string, "title": string},
    ~serviceTagline: string,
    ~operatorLogo: {"alt": string, "imgUrl": string, "orientation": string}=?,
    ~serviceTitle: string,
  ) => React.element = "default"
}

module Card = {
  @react.component @module("@codegouvfr/react-dsfr/Card")
  external make: (
    ~title: string,
    ~desc: string,
    ~linkProps: {"href": string},
    ~enlargeLink: bool=?,
    ~size: string=?,
  ) => React.element = "default"
}

module CallOut = {
  @react.component @module("@codegouvfr/react-dsfr/CallOut")
  external make: (~title: string=?, ~children: React.element, ~iconId: string=?) => React.element =
    "default"
}
