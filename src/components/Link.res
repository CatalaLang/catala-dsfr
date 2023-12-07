@react.component
let make = (~href: string, ~children) => {
  <a
    href={href}
    onClick={evt => {
      ReactEvent.Mouse.preventDefault(evt)
      Nav.goTo(href)
    }}>
    children
  </a>
}
