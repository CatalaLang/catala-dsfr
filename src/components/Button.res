module Internal = {
  @react.component
  let make = (~target, ~priority, ~children) => {
    <Dsfr.Button size="medium" onClick={_ => Nav.goTo(target)} priority> children </Dsfr.Button>
  }
}

module RightAlign = {
  @react.component
  let make = (~props) =>
    <div className="inline-flex w-full justify-end">
      <Dsfr.Button {...props} />
    </div>
}
