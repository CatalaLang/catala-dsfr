type getPromise<'a> = unit => promise<'a>

module Import = {
  module Meta = {
    type opts = {@as("as") as_?: string}

    external glob: string => Dict.t<getPromise<'a>> = "import.meta.glob"

    external globWithOpts: (string, opts) => Dict.t<getPromise<'a>> = "import.meta.glob"

    external env: 'a = "import.meta.env"
  }
}
