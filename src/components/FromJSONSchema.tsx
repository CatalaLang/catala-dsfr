import Form, { FormProps } from "@rjsf/core";
import {
  SubmitButtonProps,
  WidgetProps,
  FieldProps,
  RegistryFieldsType,
  FieldTemplateProps,
  ArrayFieldTemplateProps,
} from "@rjsf/utils";
import { Input } from "@codegouvfr/react-dsfr/Input";
import { Button } from "@codegouvfr/react-dsfr/Button";
import { Select } from "@codegouvfr/react-dsfr/Select";
import { Checkbox } from "@codegouvfr/react-dsfr/Checkbox";
import { Tabs } from "@codegouvfr/react-dsfr/Tabs";
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
  uiSchema,
  ...rest
}: WidgetProps) {
  if (type === "date") {
    value = value ?? new Date().toISOString().split("T")[0];
    onChange(value);
  }
  return (
    <Input
      label={label}
      hintText={uiSchema["ui:help"]}
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

function ArrayFieldTemplate(props: ArrayFieldTemplateProps) {
  console.log("props.canAdd", props.canAdd);
  return (
    <div className="form-group field">
      <div className="fr-input-group">
        <label className="fr-label">{props.title}</label>
        <div className="fr-input-wrap">
          <Tabs
            tabs={props.items
              .map((element) => ({
                label: `${element.uiSchema["ui:title"]} ${element.index + 1}`,
                content: (
                  <>
                    <Button
                      iconId="fr-icon-delete-fill"
                      onClick={element.onDropIndexClick(element.index)}
                      title="Supprimer"
                    />
                    {element.children}
                  </>
                ),
              }))
              .concat([
                {
                  label: "Ajouter",
                  content: (
                    <>
                      {props.canAdd && (
                        <Button
                          iconId="fr-icon-add-circle-fill"
                          onClick={props.onAddClick}
                          title={props.title}
                        />
                      )}
                    </>
                  ),
                },
              ])}
          />
        </div>
      </div>
    </div>
  );
}

function CheckBoxDsfr(props: WidgetProps) {
  return (
    <div style={{ marginTop: "1rem", marginBottom: "-1rem" }}>
      <Checkbox
        options={[
          {
            label: props.schema.title,
            hintText: props.uiSchema["ui:help"],
            nativeInputProps: {
              checked: props.value,
              onChange: (e) => props.onChange(e.target.checked),
            },
          },
        ]}
      />
    </div>
  );
}

function SubmitButton(_props: SubmitButtonProps) {
  return (
    <div className="flex w-full justify-center">
      <Button>Lancer le calcul !</Button>
    </div>
  );
}

function FieldTemplate({
  classNames,
  style,
  description,
  errors,
  children,
}: FieldTemplateProps) {
  return (
    <div className={classNames} style={style}>
      {description}
      {children}
      {errors}
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
        CheckboxWidget: CheckBoxDsfr,
      }}
      templates={{
        ArrayFieldTemplate,
        BaseInputTemplate,
        FieldTemplate,
        ButtonTemplates: { SubmitButton },
      }}
    />
  );
}
