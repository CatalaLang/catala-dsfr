// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Client from "react-dom/client";

function App$App(props) {
  return React.createElement("div", undefined, React.createElement("p", undefined, "Hello, world!"));
}

var App = {
  make: App$App
};

var element = document.querySelector("#app-root");

if (!(element == null)) {
  Client.createRoot(element).render(React.createElement(App$App, {}));
}

export {
  App ,
}
/* element Not a pure module */
