type imgLocation = {default: string}

let logo: imgLocation = %raw("import('../assets/logo.png')")

@react.component
let make = () => {
  <div className="flex w-screen bg-primary_light fixed p-2">
    <button className="flex bg-transparent" onClick={_ => Nav.goTo("/")}>
      <img className="h-8 pr-2" src={logo.default} />
      <h2 className="text-xl px-1"> {`Catala`->React.string} </h2>
      <h2 className="text-xl italic"> {`Explorer`->React.string} </h2>
    </button>
  </div>
}
