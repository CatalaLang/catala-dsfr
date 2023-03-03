module Dsfr = {
  @react.component @module("@codegouvfr/react-dsfr/Card")
  external make: (
    ~title: string,
    ~desc: string,
    ~linkProps: {"href": string},
    ~enlargeLink: bool=?,
    ~size: string=?,
  ) => React.element = "default"
}
