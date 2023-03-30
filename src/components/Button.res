module Internal = {
  @react.component
  let make = (~target, ~priority, ~children) => {
    <Dsfr.Button size="medium" onClick={_ => Nav.goTo(target)} priority>
      children
    </Dsfr.Button>
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
            <Dsfr.Button size="small" priority={isPrimary ? "primary" : "secondary"} onClick={button.onClick->Belt.Option.getExn}>
            {content}
              {button.label->React.string}
            </Dsfr.Button>
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
