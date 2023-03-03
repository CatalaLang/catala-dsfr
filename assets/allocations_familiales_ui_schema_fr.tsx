import { FieldProps, WidgetProps } from "@rjsf/core";

export const uiSchema = {
  iDateCouranteIn: {},
  iRessourcesMenageIn: {},
  iPersonneChargeEffectivePermanenteRemplitTitreIIn: {
    "ui:help":
      "Voir le code de la sécurité sociale, partie législative, livre V, titre I pour plus d'informations.",
  },
  iEnfantsIn: {
    items: {
      dRemunerationMensuelle: {
        "ui:help":
          "Valeur déclarative à l'instar des ressources annuelles du ménage.",
      },
      dADejaOuvertDroitAuxAllocationsFamiliales: {
        "ui:help":
          "Voir l'article L521-1 du code de la sécurité sociale pour plus d'informations.",
      },
      dBeneficieTitrePersonnelAidePersonnelleLogement: {
        "ui:help":
          "Voir l'article L821-3 du code de la construction et de l'habitation pour plus d'informations.",
      },
    },
  },
  iAvaitEnfantAChargeAvant1erJanvier2012In: {
    "ui:help":
      "Voir l'annexe du décret n°2002-423 du 29 mars 2002 relatif aux prestations familiales à Mayotte pour plus d'informations.",
    // "ui:widget": "checkbox",
  },
  iPersonneChargeEffectivePermanenteEstParentIn: {
    "ui:help":
      "Voir l'article L521-2 du code de la sécurité sociale pour plus d'informations.",
  },
  iResidenceIn: {
    "ui:field": "select",
  },
  "ui:submitButtonOptions": {
    props: {
      "ui:classNames": "fr-btn",
    },
    submitText: "Lancer le calcul !",
  },
};
