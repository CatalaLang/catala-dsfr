module Spa = {
  type startReactDsfrParams<'props> = {
    defaultColorScheme: [#light | #dark | #system],
    verbose?: bool,
    @as("Link") link: 'props => React.element,
    useLang?: unit => [#fr | #en],
  }

  @module("@codegouvfr/react-dsfr/spa")
  external startReactDsfr: startReactDsfrParams<'props> => unit = "startReactDsfr"
}

module Button = {
  @react.component @module("@codegouvfr/react-dsfr/Button")
  external make: (
    ~children: React.element,
    ~disabled: bool=?,
    ~iconId: string=?,
    ~iconPosition: string=?,
    ~onClick: JsxEvent.Mouse.t => unit,
    ~priority: string=?,
    ~size: string=?,
  ) => React.element = "default"
}

module CallOut = {
  @react.component @module("@codegouvfr/react-dsfr/CallOut")
  external make: (~title: string=?, ~children: React.element, ~iconId: string=?) => React.element =
    "default"
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

module Footer = {
  @react.component @module("@codegouvfr/react-dsfr/Footer")
  external make: (
    ~accessibility: string,
    ~brandTop: React.element=?,
    ~contentDescription: React.element=?,
    ~homeLinkProps: {"href": string, "title": string}=?,
    ~bottomItems: array<'button>=?,
    ~license: React.element=?,
  ) => React.element = "default"
}

module Display = {
  @module("@codegouvfr/react-dsfr/Display")
  external headerFooterDisplayItem: 'button = "headerFooterDisplayItem"
}

module Notice = {
  @react.component @module("@codegouvfr/react-dsfr/Notice")
  external make: (~title: string, ~isClosable: bool=?) => React.element = "default"
}
