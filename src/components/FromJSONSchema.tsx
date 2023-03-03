import Form, { FormProps } from "@rjsf/core";
import {
  RegistryFieldsType,
  SubmitButtonProps,
  WidgetProps,
  FieldProps,
} from "@rjsf/utils";
import { Input } from "@codegouvfr/react-dsfr/Input";
import { Button } from "@codegouvfr/react-dsfr/Button";
import { Select } from "@codegouvfr/react-dsfr/Select";
import { Checkbox } from "@codegouvfr/react-dsfr/Checkbox";
import validator from "@rjsf/validator-ajv8";
import { useState } from "react";

function SelectFieldDSFR(props: FieldProps) {
  return (
    <Select
      label="Label pour liste déroulante"
      nativeSelectProps={{
        id: props.id,
        name: props.name,
        required: props.required,
        onChange: (e) => {
          console.log("e.target.value", e.target.value);
          const item = props.schema.properties.kind.anyOf[e.target.value];
          props.onChange(item);
          console.log("item.title:", item);
          return item;
        },
      }}
      placeholder="Sélectionnez une option"
    >
      {props.schema.properties.kind.anyOf.map((item, index) => (
        <option key={index} value={index}>
          {item.title}
        </option>
      ))}
    </Select>
  );
}

function BaseInputTemplate({
  label,
  required,
  placeholder,
  type,
  value,
  onChange,
  ...rest
}: WidgetProps) {
  if (type === "date") {
    value = new Date().toISOString().split("T")[0];
    onChange(value);
  }
  return (
    <Input
      // label={label}
      nativeInputProps={{
        type: type,
        required: required,
        placeholder: placeholder,
        onChange: (e) => onChange(e.target.value),
        min: rest.schema.minimum,
        value: value,
      }}
      {...rest}
    />
  );
}

function CheckBoxDsfr(props: WidgetProps) {
  return <Checkbox options={[{ label: props.label }]} />;
}

function SubmitButton(_props: SubmitButtonProps) {
  return (
    <div className="flex w-full justify-center">
      <Button>Lancer le calcul !</Button>
    </div>
  );
}

export default function FormRJSF(props: FormProps<any>) {
  return (
    <Form
      schema={props.schema}
      uiSchema={props.uiSchema}
      formData={props.formData}
      onChange={props.onChange}
      onSubmit={props.onSubmit}
      onError={props.onError}
      validator={validator}
      fields={{
        select: SelectFieldDSFR,
      }}
      widgets={{
        select: SelectFieldDSFR,
      }}
      templates={{ BaseInputTemplate, ButtonTemplates: { SubmitButton } }}
    />
  );
}
