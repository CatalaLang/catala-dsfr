/*
	Wrapper around the [french_law.js] library.
*/

/* Log events related functions. */

let resetLog: unit => unit

let retrieveRawEventsSerialized: unit => array<LogEvent.Raw.eventSerialized>

let retrieveEventsSerialized: unit => array<LogEvent.eventSerialized>

/* French algorithms API */

type french_law<'a> = {
  eventsManager: 'a,
  computeAllocationsFamiliales: 'a,
  computeAidesAuLogement: 'a,
}

/* Root of the JS library. */
let frenchLawLib: french_law<Js.Json.t>

/* Resets logs before calling [french_law.computeAllocationsFamiliales]. */
let computeAllocationsFamiliales: Js.Json.t => float

/* Resets logs before calling [french_law.computeAidesAuLogement]. */
let computeAidesAuLogement: Js.Json.t => float
