module String = {
  @react.component
  let make = (~french: string, ~english: string) => {
    ignore(english)
    React.string(french)
  }
}
