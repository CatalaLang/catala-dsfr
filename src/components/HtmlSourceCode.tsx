import React, { useEffect } from "react";
import scrollToAndHighlightLine from "../utils/scrollAndHightlightLine";

export default function ({ html, hash }) {
  useEffect(() => {
    if (window.MathJax) {
      window.MathJax.typeset();
    }
  });

  useEffect(() => {
    if (hash !== "") {
      try {
        console.log("calling scrollToAndHighlightLine with:", hash);
        scrollToAndHighlightLine(document.getElementById("app-root"), hash);
      } catch (e) {
        console.error(`Error while scrolling to id ${hash}:`);
        console.error(e);
      }
    }
  }, [hash]);

  return (
    <div className="catala-code" dangerouslySetInnerHTML={{ __html: html }} />
  );
}
