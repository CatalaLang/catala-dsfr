type linkProps = {"href": string, "title": string}

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

module Badge = {
  type severity = [#success | #info | #warning | #error]
  type tag = [#span | #div | #p]
  @react.component @module("@codegouvfr/react-dsfr/Badge")
  external make: (
    ~className: string=?,
    ~children: React.element,
    ~noIcon: bool=?,
    ~small: bool=?,
    ~severity: severity=?,
    @as("as") ~as_: tag=?,
  ) => React.element = "default"
}

module Breadcrumb = {
  type segment = {label: string, linkProps: linkProps}
  @react.component @module("@codegouvfr/react-dsfr/Breadcrumb")
  external make: (
    ~id: string=?,
    ~className: string=?,
    ~homeLinkProps: linkProps=?,
    ~segments: array<segment>,
    ~currentPageLabel: string=?,
  ) => React.element = "default"
}

module Button = {
  type options = {
    disabled?: bool,
    iconId?: string,
    iconPosition?: string,
    onClick: ReactEvent.Mouse.t => unit,
    priority?: string,
    size?: string,
    children: React.element,
  }

  @react.component @module("@codegouvfr/react-dsfr/Button")
  external make: (
    ~children: React.element,
    ~disabled: bool=?,
    ~iconId: string=?,
    ~iconPosition: string=?,
    ~onClick: ReactEvent.Mouse.t => 'a,
    ~priority: string=?,
    ~size: string=?,
  ) => React.element = "default"
}

module ButtonsGroup = {
  @react.component @module("@codegouvfr/react-dsfr/ButtonsGroup")
  external make: (
    ~alignment: string=?,
    ~buttonsSize: string=?,
    ~buttonsIconPosition: string=?,
    ~buttonsEquisized: bool=?,
    ~buttons: array<Button.options>,
    ~inlineLayoutWhen: string=?,
    ~className: string=?,
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
    ~linkProps: linkProps,
    ~enlargeLink: bool=?,
    ~size: string=?,
  ) => React.element = "default"
}

module Header = {
  @react.component @module("@codegouvfr/react-dsfr/Header")
  external make: (
    ~brandTop: React.element=?,
    ~homeLinkProps: linkProps,
    ~serviceTagline: string,
    ~operatorLogo: {"alt": string, "imgUrl": string, "orientation": string}=?,
    ~serviceTitle: React.element,
  ) => React.element = "default"
}

module Footer = {
  @react.component @module("@codegouvfr/react-dsfr/Footer")
  external make: (
    ~accessibility: string,
    ~brandTop: React.element=?,
    ~contentDescription: React.element=?,
    ~homeLinkProps: linkProps=?,
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
