@react.component
let make: (
  ~assetsVersion: string,
  ~frenchLaw: CatalaFrenchLaw.t,
  ~formInfos: FormInfos.t,
) => React.element
