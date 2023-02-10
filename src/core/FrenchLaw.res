type french_law<'a> = {
  eventsManager: 'a,
  computeAllocationsFamiliales: 'a,
  computeAidesAuLogement: 'a,
}

%%raw(`import * as frenchLaw from "../../assets/french_law.js"`)
%%raw(`console.log('frenchLaw 2:', frenchLaw.default)`)

let resetLog: unit => unit = %raw(`
  function() {
    console.log("resetLog:", frenchLaw)
    return frenchLaw.eventsManager.resetLog(0);
  }
`)

let retrieveRawEventsSerialized: unit => array<LogEvent.Raw.eventSerialized> = %raw(`
  function() {
    return frenchLaw.eventsManager.retrieveRawEvents(0);
  }
`)

let retrieveEventsSerialized: unit => array<LogEvent.eventSerialized> = %raw(`
  function() {
    return frenchLaw.eventsManager.retrieveEvents(0);
  }
`)

let computeAllocationsFamiliales: Js.Json.t => float = %raw(`
  function(input) {
    frenchLaw.eventsManager.resetLog(0);
    return frenchLaw.computeAllocationsFamiliales(input);
  }
`)

let computeAidesAuLogement: Js.Json.t => float = %raw(`
  function(input) {
    renchLaw.eventsManager.resetLog(0);
    return frenchLaw.computeAidesAuLogement(input);
  }
`)
