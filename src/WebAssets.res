// TODO: migrate to @catala-lang/catala-web-assets

%%raw(`
import familyBenefitsSchemaFr from "../assets/allocations_familiales_schema_fr.json";
import familyBenefitsUISchema from "../assets/allocations_familiales_ui_schema_fr.json";

import {uiSchema as housingBenefitsUISchemaFr} from "../assets/aides_logement_ui_fr.schema.jsx";
import housingBenefitsSchema from "../assets/aides_logement_schema_fr.json";
import housingBenefitsInitialData from "../assets/aides_logement_init.json";
`)

type t = {
  schema: JSON.t,
  uiSchema: JSON.t,
  initialData?: JSON.t,
}

let frenchFamilyAssets: t = {
  schema: %raw(`familyBenefitsSchemaFr`),
  uiSchema: %raw(`familyBenefitsUISchema`),
}

let frenchHousingAssets: t = {
  schema: %raw(`housingBenefitsSchema`),
  uiSchema: %raw(`housingBenefitsUISchemaFr`),
  initialData: %raw(`housingBenefitsInitialData`),
}
