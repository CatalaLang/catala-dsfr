module Dsfr = {
  @react.component @module("@codegouvfr/react-dsfr/Tile")
  external make: (
    ~title: string,
    ~desc: React.element,
    ~enlargeLink: bool=?,
    ~linkProps: {"href": string},
    ~horizontal: bool=?,
    ~imageUrl: string=?,
  ) => React.element = "default"
}
