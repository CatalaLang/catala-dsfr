type t = {
  version: string,
  computeAllocationsFamiliales: Js.Json.t => float,
  computeAidesAuLogement: Js.Json.t => float,
  resetLog: unit => unit,
  retrieveRawEventsSerialized: unit => array<CatalaRuntime.Raw.eventSerialized>,
  retrieveEventsSerialized: unit => array<CatalaRuntime.eventSerialized>,
}

let get: string => unit => promise<t>
