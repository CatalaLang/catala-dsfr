%%raw(`import "./css/index.css";`)
%%raw(`import { startReactDsfr } from '@codegouvfr/react-dsfr/spa';`)

%%raw(`startReactDsfr({ defaultColorScheme: "system"});`)

module App = {
  @react.component
  let make = () => {
    <>
      <Header />
      <div className="flex flex-col items-center justify-center"> <Router /> </div>
      <Footer />
    </>
  }
}

ReactDOM.Client.createRoot(
  ReactDOM.querySelector("#app-root")->Belt.Option.getExn,
)->ReactDOM.Client.Root.render(<React.StrictMode> <App /> </React.StrictMode>)
