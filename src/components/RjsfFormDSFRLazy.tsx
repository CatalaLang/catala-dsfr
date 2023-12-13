import { lazy } from "react";
import { FormProps } from "@rjsf/core";

const FormRJSFLazy = lazy(() => import("./RjsfFormDSFR.tsx"));

export default function RjsfFormDsfrLazy(props: FormProps<any>) {
  return <FormRJSFLazy {...props} />;
}
