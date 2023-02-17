type french_law<'a> = {
  eventsManager: 'a,
  computeAllocationsFamiliales: 'a,
  computeAidesAuLogement: 'a,
}

%%raw(`import * as frenchLaw from "../../assets/french_law.cjs"`)
%%raw(`console.log('frenchLaw 2:', frenchLaw.default)`)

let frenchLawLib: french_law<Js.Json.t> = %raw(`frenchLaw.default`)

let resetLog: unit => unit = %raw(`
  function() {
    console.log("resetLog:", frenchLawLib)
    return frenchLawLib.eventsManager.resetLog(0);
  }
`)

let retrieveRawEventsSerialized: unit => array<LogEvent.Raw.eventSerialized> = %raw(`
  function() {
    return frenchLawLib.eventsManager.retrieveRawEvents(0);
  }
`)

let retrieveEventsSerialized: unit => array<LogEvent.eventSerialized> = %raw(`
  function() {
    return frenchLawLib.eventsManager.retrieveEvents(0);
  }
`)

let computeAllocationsFamiliales: Js.Json.t => float = %raw(`
  function(input) {
    frenchLawLib.eventsManager.resetLog(0);
    return frenchLawLib.computeAllocationsFamiliales(input);
  }
`)

let computeAidesAuLogement: Js.Json.t => float = %raw(`
  function(input) {
    renchLaw.eventsManager.resetLog(0);
    return frenchLawLib.computeAidesAuLogement(input);
  }
`)
