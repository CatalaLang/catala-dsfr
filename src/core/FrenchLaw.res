open Vite

let frenchLawImports = Import.Meta.globWithOpts(
  "../../french-law/**/french_law.js",
  {
    import: "default",
  },
)

type t = {
  version: string,
  computeAllocationsFamiliales: Js.Json.t => float,
  computeAidesAuLogement: Js.Json.t => float,
  resetLog: unit => unit,
  retrieveRawEventsSerialized: unit => array<CatalaRuntime.Raw.eventSerialized>,
  retrieveEventsSerialized: unit => array<CatalaRuntime.eventSerialized>,
}

let resetLog = fl => {
  fl["eventsManager"]["resetLog"]()
}

let retrieveRawEventsSerialized = fl => {
  fl["eventsManager"]["retrieveRawEvents"]()
}
let retrieveEventsSerialized = fl => {
  fl["eventsManager"]["retrieveEvents"]()
}

let computeAllocationsFamiliales = (fl, input) => {
  resetLog(fl)
  fl["computeAllocationsFamiliales"](input)
}

let computeAidesAuLogement = (fl, input) => {
  resetLog(fl)
  fl["computeAidesAuLogement"](input)
}

let get = version => {
  switch frenchLawImports->Dict.get(`../../french-law/${version}/french_law.js`) {
  | Some(frenchLawImport) =>
    async () => {
      let frenchLaw = await frenchLawImport()
      {
        version,
        computeAllocationsFamiliales: computeAllocationsFamiliales(frenchLaw, ...),
        computeAidesAuLogement: computeAidesAuLogement(frenchLaw, ...),
        resetLog: () => resetLog(frenchLaw, ...),
        retrieveRawEventsSerialized: () => retrieveRawEventsSerialized(frenchLaw, ...),
        retrieveEventsSerialized: () => retrieveEventsSerialized(frenchLaw, ...),
      }
    }
  | _ => Js.Exn.raiseError(`Version ${version} not found in ${Versions.available->Array.toString}`)
  }
}
