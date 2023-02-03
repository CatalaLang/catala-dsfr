%%raw("import { startReactDsfr } from '@codegouvfr/react-dsfr/spa';")

%%raw(`startReactDsfr({ defaultColorScheme: "system"});`)

module App = {
  @react.component
  let make = () => {
    <div> <p> {React.string("Hello, world!")} </p> </div>
  }
}

ReactDOM.Client.createRoot(
  ReactDOM.querySelector("#app-root")->Belt.Option.getExn,
)->ReactDOM.Client.Root.render(<React.StrictMode> <App /> </React.StrictMode>)
