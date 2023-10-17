type url = string

let goTo = (newUrl: url) => {
  Js.log("goTo: " ++ newUrl)
  RescriptReactRouter.push(newUrl)
}

let goToPath = (path: list<url>) => {
  path->List.toArray->Array.joinWith("/")->goTo
}
