type url = string

let basePath = Constants.baseURL->String.split("/")->Array.filter(s => s != "")->List.fromArray

let getCurrentURL = () => {
  let url = RescriptReactRouter.useUrl()
  let path = url.path->List.drop(basePath->List.length)->Option.getExn
  Console.log2("[INFO] - currentPath:", path->List.toArray)
  {...url, path}
}

let goTo = (newUrl: url) => {
  let url = Constants.baseURL == "/" ? newUrl : Constants.baseURL ++ (newUrl != "/" ? newUrl : "")

  Console.log2("[INFO] - new url:", url)
  RescriptReactRouter.push(url)
  %raw(`window.scrollTo(0, 0)`)
}

let goToPath = (path: list<url>) => {
  path->List.toArray->Array.joinWith("/")->goTo
}
