let useImport = (importFn, setValue) => {
  React.useEffect2(() => {
    importFn()->Promise.thenResolve(value => setValue(_ => Some(value)))->Promise.done
    None
  }, (importFn, setValue))
}
