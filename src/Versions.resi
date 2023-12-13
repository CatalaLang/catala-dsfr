type t = {"catala-web-assets": string, "french-law": string, "name": string}
let available: array<t>
let latest: t
let isAvailable: string => bool

/**
 * Supposed to be checked with isAvailable
 */
let getUnsafe: string => t
