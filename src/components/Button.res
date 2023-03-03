module Dsfr = {
  @react.component
  @module("@codegouvfr/react-dsfr/Button")
  external make: (
    ~priority: string=?,
    ~size: string=?,
    ~iconId: string=?,
    ~iconPosition: string=?,
    ~onClick: JsxEvent.Mouse.t => unit,
    ~children: React.element,
  ) => React.element = "default";
}

module Internal = {
  @react.component
  let make = (~target, ~priority, ~children) => {
    <Dsfr size="medium" onClick={_ => Nav.goTo(target)} priority>
      children
    </Dsfr>
  }
}

module Group = {
  type buttonInfos = {
    label: string,
    isPrimary?: bool,
    target?: Nav.url,
    onClick?: JsxEvent.Mouse.t => unit,
    body?: React.element,
  }
  @react.component
  let make = (~buttons: array<buttonInfos>) => {
    <ul className="fr-btns-group">
      {buttons
      ->Belt.Array.map(button => {
        let isPrimary = button.isPrimary->Belt.Option.getWithDefault(false)
        let content = button.body->Belt.Option.getWithDefault(<></>)
        <li>{
        (switch (button.target) {
        | None =>
            <Dsfr size="small" priority={isPrimary ? "primary" : "secondary"} onClick={button.onClick->Belt.Option.getExn}>
            {content}
              {button.label->React.string}
            </Dsfr>
        | Some(target) =>
            <Internal
              target
              priority={isPrimary ? "primary" : "secondary"}>
              {content}
              {button.label->React.string}
            </Internal>
          })}
          </li>
      })
      ->React.array}
    </ul>
  }
}

@react.component
let make = (~onClick, ~children) => {
  <button
    className="cursor-pointer bg-button_bg py-2 px-4 text-button_fg text-base inline-flex \
      items-center rounded font-semibold font-sans shadow-sm \
      hover:bg-button_bg_hover hover:text-button_fg_hover ease-in duration-150 "
    onClick>
    children
  </button>
}
