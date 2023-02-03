module App = {
  @react.component
  let make = () => {
    <div> <p> {React.string("Hello, world!")} </p> </div>
  }
}

switch ReactDOM.querySelector("#app-root") {
| Some(element) => ReactDOM.Client.createRoot(element)->ReactDOM.Client.Root.render(<App />)
| None => ()
}
