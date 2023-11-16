@react.component
let make = (~href: string, ~children) => {
  <a
    href={href}
    onClick={evt => {
      evt->ReactEvent.Mouse.preventDefault
      href->Nav.goTo
    }}>
    children
  </a>
}
