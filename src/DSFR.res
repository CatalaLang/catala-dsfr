// TODO: clean the dsfr bindings + publish as a standalone package

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

module Accordion = {
  @react.component @module("@codegouvfr/react-dsfr/Accordion")
  external make: (
    ~label: string,
    ~children: React.element,
    ~defaultExpanded: bool=?,
    ~onChange: bool => unit=?,
  ) => React.element = "default"
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
  @react.component @module("@codegouvfr/react-dsfr/Button")
  external make: (
    ~children: React.element,
    ~disabled: bool=?,
    ~iconId: string=?,
    ~iconPosition: [#left | #right]=?,
    ~onClick: ReactEvent.Mouse.t => 'a,
    ~priority: [#primary | #secondary | #tertiary | #"tertiary no outline"]=?,
    ~size: [#small | #medium | #large]=?,
    ~className: string=?,
  ) => React.element = "default"
}

module ButtonsGroup = {
  @react.component @module("@codegouvfr/react-dsfr/ButtonsGroup")
  external make: (
    ~alignment: [#left | #center | #right | #between]=?,
    ~buttonsSize: [#small | #medium | #large]=?,
    ~buttonsIconPosition: [#left | #right]=?,
    ~buttonsEquisized: bool=?,
    ~buttons: array<
      // FIXME: can we find a way to avoid this duplication Button?
      Button.props<
        React.element,
        bool,
        string,
        [#left | #right],
        ReactEvent.Mouse.t => 'a,
        [
          | #primary
          | #secondary
          | #tertiary
          | #"tertiary no outline"
        ],
        [#large | #medium | #small],
        string,
      >,
    >,
    ~inlineLayoutWhen: [#always | #"sm and up" | #"md and up" | #"lg and up"]=?,
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
    ~operatorLogo: {"alt": string, "imgUrl": string, "orientation": [#horizontal | #vertical]}=?,
    ~serviceTitle: React.element,
    ~navigation: array<{
      "linkProps": {"href": string, "target": string},
      "isActive": bool,
      "text": string,
    }>=?,
    ~quickAccessItems: array<{
      "buttonProps": {"onClick": ReactEvent.Mouse.t => unit},
      "text": string,
      "iconId": string,
    }>=?,
  ) => React.element = "default"
}

module Footer = {
  @react.component @module("@codegouvfr/react-dsfr/Footer")
  external make: (
    ~className: string=?,
    ~accessibility: string,
    ~brandTop: React.element=?,
    ~contentDescription: React.element=?,
    ~homeLinkProps: linkProps=?,
    ~bottomItems: array<'button>=?,
    ~license: React.element=?,
    ~operatorLogo: {"alt": string, "imgUrl": string, "orientation": [#horizontal | #vertical]}=?,
  ) => React.element = "default"
}
module Select = {
  type selectOption<'a> = {value: 'a, label: string}
  type nativeSelectProps<'a, 'b> = {id?: string, name?: string, value: 'a, onChange: 'b}

  @react.component @module("@codegouvfr/react-dsfr/Select")
  external make: (
    ~label: string,
    ~options: array<selectOption<'a>>,
    ~placeholder: string=?,
    ~nativeSelectProps: nativeSelectProps<'a, 'b>=?,
  ) => React.element = "default"
}

module Display = {
  @module("@codegouvfr/react-dsfr/Display")
  external headerFooterDisplayItem: 'button = "headerFooterDisplayItem"
}

module Notice = {
  @react.component @module("@codegouvfr/react-dsfr/Notice")
  external make: (~title: React.element, ~isClosable: bool=?) => React.element = "default"
}
