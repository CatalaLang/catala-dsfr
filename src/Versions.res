type t = {"name": string, "french-law": string, "catala-web-assets": string}

@module("../assets-versions.json") external _available: array<t> = "available"

let available = _available->Array.toSorted((a, b) => String.compare(b["name"], a["name"]))
let latest = switch available->Array.get(0) {
| Some(version) => version
| None => Js.Exn.raiseError("No version available, please check 'assets-versions.json'")
}

let isAvailable = version => {
  available->Array.find(v => v["name"] == version)->Option.isSome
}

let getUnsafe = version => {
  available->Array.find(v => v["name"] == version)->Option.getUnsafe
}
