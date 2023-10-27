import { RefObject, lazy } from "react";

type Props = {
  html: string;
  domRef: RefObject<HTMLElement>;
};

const HtmlSourceCode = lazy(() => import("./HtmlSourceCode.tsx"));

export default function (props: Props) {
  return <HtmlSourceCode {...props} />;
}
