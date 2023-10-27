import React, { useEffect } from "react";
import scrollToAndHighlightLine from "../utils/scrollAndHightlightLine";

export default function ({ html, hash }) {
  useEffect(() => {
    if (hash !== "") {
      scrollToAndHighlightLine(document.getElementById("app-root"), hash);
    }
  }, [hash]);

  return (
    <div className="catala-code" dangerouslySetInnerHTML={{ __html: html }} />
  );
}
