import { lazy } from "react";
import { FormProps } from "@rjsf/core";

const FormRJSFLazy = lazy(() => import("./RjsfFormDsfr.tsx"));

export default function RjsfFormDsfrLazy(props: FormProps<any>) {
  return <FormRJSFLazy {...props} />;
}
