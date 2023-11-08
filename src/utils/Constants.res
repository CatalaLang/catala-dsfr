let isDevMode: bool = %raw(`import.meta.env.DEV`)
let baseURL: string = %raw(`import.meta.env.BASE_URL`)

let codeGouvURL = "https://code.gouv.fr/demos/catala"
let localURL = "http://localhost:5173"

let host = isDevMode ? localURL : codeGouvURL
