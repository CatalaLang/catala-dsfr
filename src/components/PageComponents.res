module Title = {
  @react.component
  let make = (~children) => <h1 className="text-h1 mb-h1 font-bold"> children </h1>
}

module Section = {
  @react.component
  let make = (~title: React.element, ~children) => <>
    <h2 className="text-3xl my-4 font-sans">
      <span className="text-background font-sans font-semibold"> title </span>
    </h2>
    children
  </>
}
