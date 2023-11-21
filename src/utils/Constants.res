let isDevMode: bool = Vite.Import.Meta.env["DEV"]
let baseURL: string = Vite.Import.Meta.env["BASE_URL"]

let codeGouvURL = "https://code.gouv.fr/demos/catala"
let localURL = "http://localhost:5173"

let host = isDevMode ? localURL : codeGouvURL
