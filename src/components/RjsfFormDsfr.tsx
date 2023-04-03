import { useCallback } from "react";
import Form, { FormProps } from "@rjsf/core";
import {
  SubmitButtonProps,
  WidgetProps,
  FieldProps,
  FieldTemplateProps,
  ArrayFieldTemplateProps,
  enumOptionsValueForIndex,
  enumOptionsIndexForValue,
  RJSFSchema,
  TitleFieldProps,
} from "@rjsf/utils";
import { Input } from "@codegouvfr/react-dsfr/Input";
import { Button } from "@codegouvfr/react-dsfr/Button";
import { Select } from "@codegouvfr/react-dsfr/Select";
import { Checkbox } from "@codegouvfr/react-dsfr/Checkbox";
import { Alert } from "@codegouvfr/react-dsfr/Alert";
import { Tabs } from "@codegouvfr/react-dsfr/Tabs";
import validator from "@rjsf/validator-ajv8";

const defaultAddIcon = "fr-icon-add-circle-line";
const defaultRemoveIcon = "fr-icon-delete-line";

function DetailedHint(props) {
  if (props.children == undefined) return null;
  return (
    <details className="fr-details">
      <summary>{props.summary ?? "Voir l'explication"}</summary>
      {props.children}
    </details>
  );
}

function getValue(event: SyntheticEvent<HTMLSelectElement>, multiple: boolean) {
  if (multiple) {
    return Array.from((event.target as HTMLSelectElement).options)
      .slice()
      .filter((o) => o.selected)
      .map((o) => o.value);
  }
  return (event.target as HTMLSelectElement).value;
}

function SelectWidgetDsfr(props: WidgetProps) {
  const { enumOptions, emptyValue: optEmptyVal } = props.options;

  const handleChange = useCallback(
    (event) => {
      const newValue = getValue(event, props.multiple);
      return props.onChange(
        enumOptionsValueForIndex<RJSFSchema>(newValue, enumOptions, optEmptyVal)
      );
    },
    [props.onChange, props.schema, props.multiple, props.options]
  );

  const selectedIndexes = enumOptionsIndexForValue<RJSFSchema>(
    props.value,
    props.options.enumOptions,
    props.multiple
  );

  const defaultIndex = enumOptionsIndexForValue<RJSFSchema>(
    props.schema.default,
    props.options.enumOptions,
    props.multiple
  );

  const value =
    typeof selectedIndexes === "undefined" ? defaultIndex : selectedIndexes;

  return (
    <Select
      hint={<DetailedHint>{props.uiSchema["ui:help"]}</DetailedHint>}
      nativeSelectProps={{
        id: props.id,
        name: props.name,
        required: props.required,
        value,
        onChange: handleChange,
      }}
    >
      {!props.multiple && props.schema.default === undefined && (
        <option value="">{props.placeholder}</option>
      )}
      {props.options.enumOptions.map((item, index) => (
        <option key={index} value={String(index)}>
          {item.label}
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
      hintText={<DetailedHint>{uiSchema["ui:help"]}</DetailedHint>}
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
                      iconId={uiSchema["ui:removeIcon"] ?? defaultRemoveIcon}
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
                          iconId={uiSchema["ui:addIcon"] ?? defaultAddIcon}
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
            label: props.schema.title + (props.required ? "*" : ""),
            hintText: <DetailedHint>{props.uiSchema["ui:help"]}</DetailedHint>,
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
      <Button>Lancer le calcul</Button>
    </div>
  );
}

const schemaTypesToNotRenderTitles = ["boolean", "array"];

function FieldTemplate({
  classNames,
  style,
  description,
  errors,
  children,
  id,
  required,
  label,
  schema,
}: FieldTemplateProps) {
  const title = !schemaTypesToNotRenderTitles.includes(schema.type) &&
    typeof schema.required != "object" && (
      <label className="fr-label" htmlFor={id}>
        {label}
        {required ? "*" : null}
      </label>
    );

  return (
    <div className={classNames} style={style}>
      {title}
      {description}
      {children}
      {errors.props.errors != null && (
        <Alert severity="error" description={errors} small />
      )}
    </div>
  );
}

function TitleField({ title, required, id, schema }: TitleFieldProps) {
  // Lengends and labels are managed directly by the widgets.
  return null;
}

export default function FormRJSF(props: FormProps<any>) {
  return (
    <Form
      validator={validator}
      widgets={{
        CheckboxWidget: CheckBoxDsfr,
        SelectWidget: SelectWidgetDsfr,
      }}
      templates={{
        ArrayFieldTemplate,
        BaseInputTemplate,
        FieldTemplate,
        ButtonTemplates: { SubmitButton },
        TitleFieldTemplate: TitleField,
      }}
      {...props}
    />
  );
}
