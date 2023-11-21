let getFromJSONExn = (json, key) => {
  switch JSON.Decode.object(json) {
  | Some(obj) =>
    switch obj->Dict.get(key) {
    | Some(value) => value
    | None => Js.Exn.raiseError(`Missing key ${key} in JSON object: ${JSON.stringify(json)}`)
    }
  | None => Js.Exn.raiseError(`Expected a JSON object, got: ${JSON.stringify(json)}`)
  }
}

let toUnique = a => a->Array.filterWithIndex((x, i) => a->Array.indexOf(x) === i)
