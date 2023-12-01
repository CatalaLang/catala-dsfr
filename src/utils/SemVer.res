type pre = {
  name: string,
  number: int,
}
type t = {
  major: int,
  minor: int,
  patch: int,
  pre?: pre,
}

let parse = s => {
  let parseVerions = s => {
    switch s->String.split(".") {
    | [major, minor, patch] =>
      switch (Int.fromString(major), Int.fromString(minor), Int.fromString(patch)) {
      | (Some(major), Some(minor), Some(patch)) => Some({major, minor, patch})
      | _ => None
      }
    | _ => None
    }
  }
  switch s->String.split("-") {
  | [versions] => parseVerions(versions)
  | [versions, pre] =>
    parseVerions(versions)->Belt.Option.flatMap(v => {
      switch pre->String.split(".") {
      | [name, number] =>
        switch Int.fromString(number) {
        | Some(number) => Some({...v, pre: {name, number}})
        | _ => None
        }
      | _ => None
      }
    })
  | _ => None
  }
}

let compare = (a, b) => {
  switch (parse(a), parse(b)) {
  | (
      Some({major, minor, patch} as a),
      Some({major: major', minor: minor', patch: patch'} as b),
    ) => {
      let majorCmp = major->Int.compare(major')
      let minorCmp = minor->Int.compare(minor')
      let patchCmp = patch->Int.compare(patch')

      majorCmp != Ordering.equal
        ? majorCmp
        : minorCmp != Ordering.equal
        ? minorCmp
        : patchCmp != Ordering.equal
        ? patchCmp
        : switch (a.pre, b.pre) {
          | (Some({name, number}), Some({name: name', number: number'})) => {
              let nameCmp = name->String.compare(name')
              nameCmp != Ordering.equal ? nameCmp : number->Int.compare(number')
            }
          | (Some(_), None) => Ordering.greater
          | _ => Ordering.less
          }
    }
  | (None, Some(_)) => Js.Exn.raiseError(`Invalid version: ${a}`)
  | (Some(_), None) => Js.Exn.raiseError(`Invalid version: ${b}`)
  | _ => Js.Exn.raiseError(`Invalid version: ${a} and ${b}`)
  }
}

let sort = versions => {
  versions->Utils.toUnique->Array.toSorted((a, b) => compare(b, a))
}
