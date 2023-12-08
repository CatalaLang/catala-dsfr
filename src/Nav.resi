type url = string
let basePath: RescriptCore.List.t<string>
let getCurrentURL: unit => RescriptReactRouter.url
let goTo: url => unit
let goToPath: list<url> => unit
let goToAbsolutePath: list<url> => unit
