import Form, { FormProps } from "@rjsf/core";
import { SubmitButtonProps, WidgetProps, FieldProps } from "@rjsf/utils";
import { Input } from "@codegouvfr/react-dsfr/Input";
import { Button } from "@codegouvfr/react-dsfr/Button";
import { Select } from "@codegouvfr/react-dsfr/Select";
import { Checkbox } from "@codegouvfr/react-dsfr/Checkbox";
import validator from "@rjsf/validator-ajv8";

function SelectFieldDsfr(props: FieldProps) {
  return (
    <Select
      label={props.schema.title}
      nativeSelectProps={{
        id: props.id,
        name: props.name,
        required: props.required,
        onChange: (e) => {
          props.onChange({ kind: e.target.value, payload: null });
        },
      }}
    >
      {props.schema.properties.kind.anyOf.map((item, index) => (
        <option key={index} value={item.enum[0]}>
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
        select: SelectFieldDsfr,
      }}
      widgets={{
      }}
      templates={{ BaseInputTemplate, ButtonTemplates: { SubmitButton } }}
    />
  );
}
