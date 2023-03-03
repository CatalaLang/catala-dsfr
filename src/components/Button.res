module Internal = {
  @react.component
  let make = (~style, ~target, ~children) => {
    <button className={"fr-btn " ++ style} onClick={_ => Nav.goTo(target)}> children </button>
  }
}

module Small = {
  @react.component
  let make = (~style="", ~onClick, ~children) => {
    <button className={"cursor-pointer fr-btn fr-btn-sm " ++ style} onClick>
      children
    </button>
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
            <Small style={isPrimary ? "fr-btn--primary" : "fr-btn--secondary"} onClick={button.onClick->Belt.Option.getExn}>
            {content}
              {button.label->React.string}
            </Small>
        | Some(target) =>
            <Internal
              target
              style={isPrimary ? "fr-btn--primary" : "fr-btn--secondary"}>
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
