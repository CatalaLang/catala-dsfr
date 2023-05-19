%%raw(`import "./css/index.css";`)

Dsfr.Spa.startReactDsfr({defaultColorScheme: "system", link: Router.Link.make})

module App = {
  @react.component
  let make = () => {
    <>
      <Header />
      <main role="main" className="fr-h-10w fr-p-2w">
        <Router />
      </main>
      <Footer />
    </>
  }
}

ReactDOM.Client.createRoot(
  ReactDOM.querySelector("#app-root")->Belt.Option.getExn,
)->ReactDOM.Client.Root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
