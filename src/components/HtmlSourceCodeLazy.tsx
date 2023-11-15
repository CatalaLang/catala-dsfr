import { RefObject, lazy } from "react";

type Props = {
  html: string;
  hash: string;
};

const HtmlSourceCode = lazy(() => import("./HtmlSourceCode.tsx"));

export default function (props: Props) {
  return <HtmlSourceCode {...props} />;
}
