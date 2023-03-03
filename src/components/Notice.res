module Dsfr = {
  @react.component @module("@codegouvfr/react-dsfr/Notice")
  external make: (~title: string, ~isClosable: bool=?) => React.element = "default"
}
