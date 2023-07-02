let typesetMathJax: unit => unit = %raw(`
function typesetMathJax() {
    if (window.MathJax) {
      window.MathJax.typeset();
    }
  }
`)

module DangerouslySetInnerHtml = {
  @react.component
  let make = (~html) => {
    React.useEffect(() => {
      // This assumes MathJax to be loaded in the page. Necessary for the
      // LaTeX components of the Catala code to be typeset after any
      // change in the collapsible structure of the page.
      typesetMathJax()
      None
    })
    <div
      className={"catala-code"}
      dangerouslySetInnerHTML={
        "__html": html,
      }
    />
  }
}
