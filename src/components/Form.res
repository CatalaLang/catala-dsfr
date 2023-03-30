/*
  Binding for the React component [JSONSchemaForm.default] of the package
  [react-jsonschema-form].

  The component is capable of building HTML forms out of a JSON schema.
*/
module RjsfFormDsfr = {
  @react.component @module("./RjsfFormDsfr.tsx")
  external make: (
    ~onChange: Js.Dict.t<Js.Json.t> => unit=?,
    ~onSubmit: Js.Dict.t<Js.Json.t> => unit=?,
    ~onError: _ => unit=?,
    ~schema: Js.Json.t,
    ~uiSchema: Js.Json.t=?,
    ~formData: Js.Json.t=?,
  ) => React.element = "default"
}

// Function to download or import a JSON object
@val external downloadJSONstring: string => unit = "downloadJSONstring"
%%raw(`
const downloadJSONstring = (data) => {
  const blob = new Blob([data],{type:'application/json'});
  const href = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = href;
  link.download = "data.json";
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
};
`)

// Function to read a file and get its contents as string
@val external readFileAsJSON: (Js.Json.t, Js.Json.t => 'a) => unit = "readFileAsJSON"
%%raw(`
const readFileAsJSON = (file, callback) => {
  var reader = new FileReader();
  var contents = ""
  reader.onload = function(evt) {
    contents = evt.target.result;
    var json;
    try {
      json = JSON.parse(contents)
    } catch (error) {
      console.log(error)
      json = null;
    }
    callback(json);
  };
  reader.readAsText(file);
};
`)

/*
  Builds a React component from provided information.
*/
module Make = (
  FormInfos: {
    let englishSchema: Js.Json.t
    let englishUiSchema: Js.Json.t
    let frenchSchema: Js.Json.t
    let frenchUiSchema: Js.Json.t
    let resultLabel: string

    let initFormData: option<Js.Json.t>
    let formDataPostProcessing: option<Js.Json.t => Js.Json.t>
    let computeAndPrintResult: Js.Json.t => React.element
  },
) => {
  @react.component
  let make = (
    ~setEventsOpt: (option<array<LogEvent.event>> => option<array<LogEvent.event>>) => unit,
  ) => {
    let (formData, setFormData) = React.useState(_ => {
      FormInfos.initFormData
    })
    React.useEffect2(() => {
      setEventsOpt(_ => {
        let logs = {
          try {FrenchLaw.retrieveEventsSerialized()->LogEvent.deserializedEvents} catch {
          | _ => []
          }
        }
        if 0 == logs->Belt.Array.size {
          None
        } else {
          Some(logs)
        }
      })
      None
    }, (formData, setEventsOpt))

    let (uploadedFile, setUploadedFile) = React.useState(_ => {
      Js.Json.object_(Js.Dict.empty())
    })

    let fileChangeHandler = (_event: ReactEvent.Form.t) => {
      setUploadedFile(%raw(`_event.target.files[0]`))
    }

    let retrieveFileContents = _ => {
      if %raw(`uploadedFile instanceof File`) {
        readFileAsJSON(uploadedFile, form_data => setFormData(_ => Some(form_data)))
      }
    }

    let form_header =
      <div className="fr-col-8">
        <div className="fr-container--fluid">
          <div className="fr-grid-col fr-grid-row--center">
            <div className="fr-col">
              <Button.Group
                buttons=[
                  {
                    label: `Exporter les données au format JSON`,
                    onClick: _ => {
                      let data_str = Js.Json.stringify(
                        formData->Belt.Option.getWithDefault(Js.Json.null),
                      )
                      downloadJSONstring(data_str)
                    },
                  },
                  {
                    label: `Réinitialiser le formulaire`,
                    onClick: _ => {
                      setFormData(_ => None)
                    },
                  },
                  {
                    label: `Importer les données au format JSON`,
                    onClick: retrieveFileContents,
                    body: <input type_="file" onChange={fileChangeHandler} />,
                  },
                ]
              />
            </div>
          </div>
        </div>
      </div>

    let form =
      <RjsfFormDsfr
        schema={FormInfos.frenchSchema}
        uiSchema={FormInfos.frenchUiSchema}
        formData={formData->Belt.Option.getWithDefault(Js.Json.null)}
        onSubmit={t => {
          setFormData(_ => {
            let formData = t->Js.Dict.get("formData")
            switch (FormInfos.formDataPostProcessing, formData) {
            | (Some(f), Some(formData)) => {
                let newFormData = f(formData)
                Some(newFormData)
              }

            | _ => formData
            }
          })
        }}
      />

    let form_result =
      <Dsfr.CallOut>
        {switch formData {
        | None => `En attente de la confirmation du formulaire...`->React.string
        | Some(formData) =>
          try {
            <div className="flex flex-col">
              <div>
                {FormInfos.resultLabel->React.string}
                {": "->React.string}
                {FormInfos.computeAndPrintResult(formData)}
              </div>
              <Dsfr.Button
                onClick={_ => ()}
                disabled=true
                iconPosition="right"
                iconId="fr-icon-newspaper-line">
                {`Générer une explication de la décision`->React.string}
              </Dsfr.Button>
            </div>
          } catch {
          | err => {
              %raw(`console.log('ERROR:', err)`)
              <>
                <Lang.String english="Computation error: " french={`Erreur de calcul : `} />
                {err
                ->Js.Exn.asJsExn
                ->Belt.Option.map(Js.Exn.message)
                ->Belt.Option.getWithDefault(Some(""))
                ->Belt.Option.getWithDefault("unknwon error, please retry the computation")
                ->React.string}
              </>
            }
          }
        }}
      </Dsfr.CallOut>

    <>
      <div className="fr-container--fluid">
        <div className="fr-grid-row fr-grid-row--gutters fr-grid-row--center">
          <Dsfr.Notice
            title=`Les données collectées par ce formulaire ne sont envoyées nulle part, et sont gérées uniquement par votre navigateur internet. \
            Les données sont traitées localement par un programme Javascript qui a été transmis avec le reste du site de Catala. \
            Ainsi, le site de Catala ne collecte aucune donnée de ses utilisateurs.`
            isClosable=true
          />
          form_header
          <div
            className="w-full border-2 border-solid rounded-full border-[var(--border-default-grey)]"
          />
          <div className="fr-col"> form </div>
          <div
            className="w-full border-2 border-solid rounded-full border-[var(--border-default-grey)]"
          />
          <div className="fr-col"> form_result </div>
        </div>
      </div>
    </>
  }
}
