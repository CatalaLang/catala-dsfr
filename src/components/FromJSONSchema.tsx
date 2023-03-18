import Form, { FormProps } from "@rjsf/core";
import {
  SubmitButtonProps,
  WidgetProps,
  FieldProps,
  FieldTemplateProps,
  ArrayFieldTemplateProps,
} from "@rjsf/utils";
import { Input } from "@codegouvfr/react-dsfr/Input";
import { Button } from "@codegouvfr/react-dsfr/Button";
import { Select } from "@codegouvfr/react-dsfr/Select";
import { Checkbox } from "@codegouvfr/react-dsfr/Checkbox";
import { Alert } from "@codegouvfr/react-dsfr/Alert";
import { Tabs } from "@codegouvfr/react-dsfr/Tabs";
import validator from "@rjsf/validator-ajv8";

function SelectFieldDsfr(props: FieldProps) {
  return (
    <Select
      label={props.schema.title + (!props.required ? " (optionnel)" : "")}
      nativeSelectProps={{
        id: props.id,
        name: props.name,
        required: props.required,
        value: props.value,
        defaultValue: props.defaultValue,
        onChange: (e) => {
          props.onChange({ kind: e.target.value, payload: null });
        },
      }}
    >
      <option value="" selected disabled hidden>
        {props.uiSchema["ui:placeholder"]}
      </option>
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
    value = uiSchema["ui:currentDate"]
      ? value ?? new Date().toISOString().split("T")[0]
      : value;
    onChange(value);
  }
  return (
    <Input
      label={label + (!required ? " (optionnel)" : "")}
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

function ArrayFieldTemplate({
  title,
  uiSchema,
  items,
  canAdd,
  onAddClick,
}: ArrayFieldTemplateProps) {
  const tabLabel = uiSchema["ui:tabLabel"];
  return (
    <div className="form-group field">
      <div className="fr-input-group">
        <label className="fr-label">{title}</label>
        <div className="fr-input-wrap">
          <Tabs
            tabs={items
              .map((element) => ({
                label: `${tabLabel} ${element.index + 1}`,
                content: (
                  <>
                    <Button
                      iconId={uiSchema["ui:removeIcon"]}
                      onClick={element.onDropIndexClick(element.index)}
                      size="small"
                      priority="secondary"
                    >
                      Supprimer
                    </Button>
                    {element.children}
                  </>
                ),
              }))
              .concat([
                {
                  label: `${tabLabel} ${items.length + 1}`,
                  content: (
                    <>
                      {canAdd && (
                        <Button
                          iconId={uiSchema["ui:addIcon"]}
                          onClick={onAddClick}
                          size="small"
                          priority="secondary"
                        >
                          Ajouter
                        </Button>
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
            label: props.schema.title + (!props.required ? " (optionnel)" : ""),
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
      {errors.props.errors != null && (
        <Alert severity="error" description={errors} small />
      )}
    </div>
  );
}

export default function FormRJSF(props: FormProps<any>) {
  return (
    <Form
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
      {...props}
    />
  );
}
