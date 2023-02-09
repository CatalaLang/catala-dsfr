module Header = {
  @react.component @module("@codegouvfr/react-dsfr")
  external make: (~brandTop: React.element, ~homeLinkProps: React.element) => React.element =
    "Header"
}
