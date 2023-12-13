/**
 * Try to get a value from a JSON object, throwing an exception if the key is
 * not present or if it is not a JSON object.
 */
let getFromJSONExn: (Core__JSON.t, string) => Core__JSON.t

let toUnique: array<'a> => array<'a>
