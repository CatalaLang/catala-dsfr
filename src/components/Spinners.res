module Oval = {
  @react.component @module("react-loader-spinner")
  external make: (
    ~height: int=?,
    ~width: int=?,
    ~color: string=?,
    ~visible: bool=?,
    ~secondaryColor: string=?,
    ~strokeWidth: int=?,
    ~strokeWidthSecondary: int=?,
    ~radius: int=?,
    ~wrapperClassName: string=?,
  ) => React.element = "Oval"
}

let loader =
  <Oval
    height=25
    width=25
    strokeWidth=5
    color="#518fff"
    secondaryColor="#98b4ff"
    wrapperClassName="justifyCenter"
  />
