import React, { lazy } from "react";
import { FormProps } from "@rjsf/core";
import { FormContextType, RJSFSchema, StrictRJSFSchema } from "@rjsf/utils";

const Form = lazy(() => import("@codegouvfr/rjsf-dsfr"));

export default function <
  T = any,
  S extends StrictRJSFSchema = RJSFSchema,
  F extends FormContextType = any,
>(props: FormProps<T, S, F>) {
  return <Form {...props} />;
}
