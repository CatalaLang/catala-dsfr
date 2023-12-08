module Import = {
  module Meta = {
    type opts = {@as("as") as_?: string, import?: string}

    external glob: string => Dict.t<unit => promise<'a>> = "import.meta.glob"

    external globWithOpts: (string, opts) => Dict.t<unit => promise<'a>> = "import.meta.glob"

    external env: 'a = "import.meta.env"
  }
}
