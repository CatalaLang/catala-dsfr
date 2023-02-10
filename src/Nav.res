type url = string

let goTo = (newUrl: url) => {
  Js.log("goTo: " ++ newUrl)
  RescriptReactRouter.push(newUrl)
}
