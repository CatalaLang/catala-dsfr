%%raw(`import "./css/index.css";`)
%%raw(`import { startReactDsfr } from '@codegouvfr/react-dsfr/spa';`)

%%raw(`startReactDsfr({ defaultColorScheme: "system"});`)

module App = {
  @react.component
  let make = () => {
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        height: "100vh",
      }}>
      <p className="text-3xl text-[color:var(--text-default-info)]">
        {`Catala explorer`->React.string}
      </p>
    </div>
  }
}

ReactDOM.Client.createRoot(
  ReactDOM.querySelector("#app-root")->Belt.Option.getExn,
)->ReactDOM.Client.Root.render(<React.StrictMode> <App /> </React.StrictMode>)
