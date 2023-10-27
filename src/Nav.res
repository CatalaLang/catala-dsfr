type url = string

let goTo = (newUrl: url) => {
  Js.log("goTo: " ++ newUrl)
  RescriptReactRouter.push(newUrl)
  %raw(`window.scrollTo(0, 0)`)
}

let goToPath = (path: list<url>) => {
  path->List.toArray->Array.joinWith("/")->goTo
}
