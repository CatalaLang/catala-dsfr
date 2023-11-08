let isDevMode: bool = %raw(`import.meta.env.DEV`)

let localURL = "http://localhost:5173"
let prodURL = "https://code.gouv.fr/demos/catala"

let host = isDevMode ? localURL : prodURL
