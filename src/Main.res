%%raw(`import "./css/index.css";`)

Dsfr.Spa.startReactDsfr({
  defaultColorScheme: #system,
  link: Link.make,
  useLang: () => #fr,
})

ReactDOM.Client.createRoot(
  ReactDOM.querySelector("#app-root")->Belt.Option.getExn,
)->ReactDOM.Client.Root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
