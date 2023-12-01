/**
 * Compares two semver strings.
 *
 * @raises {Js.Exn.Error} if the strings are not valid semver strings.
 */
let compare: (string, string) => Ordering.t

/**
 * Sorts (in descending order) an array of semver strings. 
 *
 * @raises {Js.Exn.Error} if the strings are not valid semver strings.
 */
let sort: array<string> => array<string>
