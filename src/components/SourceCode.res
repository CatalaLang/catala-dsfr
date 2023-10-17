%%raw(`import  "../css/catala-code.css"`)
%%raw(`import  "../css/syntax-highlighting.css"`)

/*
[scrollToAndHighlightLineNum(parentElem, ids)] scrolls into the corresponding
Catala code line of [ids] inside the [parentElem] DOM element and highlight the
line numbers.
*/
let scrollToAndHighlightLineNum: (Dom.element, string) => unit = %raw(`
function(parentElem, id) {
    if (null != parent) {
	// remove previous selected line
	parentElem.querySelectorAll(".selected").forEach((elem) =>
	    elem.className = ""
	)

	let idEscaped = id.replaceAll(/\./g, "\\\.").replaceAll(/\//g, "\\\/")
	let lineToScroll = parentElem.querySelector("#" + idEscaped)
	if (null != lineToScroll) {
	    let parent = lineToScroll.parentNode;
	    while (null != parent) {
		if ('DETAILS' == parent.nodeName) {
		    parent.setAttribute("open", true);
		    parent = null;
		}
		else {
		    parent = parent.parentNode;
		}
	    }
	    lineToScroll.scrollIntoView({block: "center"});
	    lineToScroll.className = "selected line";
	    var links = lineToScroll.parentNode.parentNode.parentNode.parentNode.firstChild.firstChild.firstChild.getElementsByTagName('A');
	    for (var i = 0; i < links.length; i++) {
		if (links[i].href.includes(id)) {
		    links[i].className = "selected number"
		} else {
		    links[i].className = ""
		}
	    }
	}
    }
}
`)

@react.component
let make = (~html: option<string>, ~simulatorUrl: string) => {
  let {hash} = RescriptReactRouter.useUrl()

  let parentDomElemRef = React.useRef(Js.Nullable.null)
  React.useEffect1(() => {
    Console.log2("parentDomElemRef", parentDomElemRef)
    switch (parentDomElemRef.current->Js.Nullable.toOption, hash) {
    | (Some(parentDomElem), ids) if ids != "" => parentDomElem->scrollToAndHighlightLineNum(ids)
    | _ => ()
    }
    None
  }, [hash])

  switch html {
  | Some(html) =>
    <div className="fr-container">
      <Button.RightAlign
        props={
          iconId: "fr-icon-equalizer-line",
          iconPosition: "left",
          priority: "tertiary",
          size: "medium",
          onClick: {_ => `/${simulatorUrl}`->Nav.goTo},
          children: {"Accéder au simulateur"->React.string},
        }
      />
      <div
        className="catala-code"
        ref={ReactDOM.Ref.domRef(parentDomElemRef)}
        dangerouslySetInnerHTML={
          "__html": html,
        }
      />
    </div>
  | None =>
    ()
    <div>
      <p> {"No source code available for this snippet."->React.string} </p>
    </div>
  }
}
