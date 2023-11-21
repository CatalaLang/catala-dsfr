/*
  Binding for the React component [JSONSchemaForm.default] of the package
  [react-jsonschema-form].

  The component is capable of building HTML forms out of a JSON schema.
*/
module RjsfFormDsfrLazy = {
  @react.component @module("./RjsfFormDsfrLazy.tsx")
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
@react.component
let make = (~assetsVersion: string, ~formInfos: FormInfos.t) => {
  let currentPath = Nav.getCurrentURL().path
  let (formData, setFormData) = React.useState(_ => None)
  let (initialData, setInitialData) = React.useState(_ => None)
  let (schemaState, setSchemaState) = React.useState(_ => None)
  let (uiSchemaState, setUiSchemaState) = React.useState(_ => None)
  let (eventsOpt, setEventsOpt) = React.useState(_ => None)

  React.useEffect1(() => {
    switch formInfos.webAssets.initialDataImport {
    | Some(init) =>
      init()
      ->Promise.thenResolve(data => {
        setInitialData(_ => Some(data))
        setFormData(_ => Some(data))
      })
      ->Promise.done
    | None => ()
    }
    None
  }, [formInfos.webAssets.initialDataImport])

  React.useEffect2(() => {
    formInfos.webAssets.schemaImport()
    ->Promise.thenResolve(schema => {
      setSchemaState(_ => Some(schema))
      None
    })
    ->Promise.done
    formInfos.webAssets.uiSchemaImport()
    ->Promise.thenResolve(uiSchema => {
      setUiSchemaState(_ => Some(uiSchema))
      None
    })
    ->Promise.done
    None
  }, (formInfos.webAssets.schemaImport, formInfos.webAssets.uiSchemaImport))

  React.useEffect2(() => {
    setEventsOpt(_ => {
      let events = {
        try {CatalaFrenchLaw.retrieveEventsSerialized()->CatalaRuntime.deserializedEvents} catch {
        | _ => []
        }
      }
      if 0 == events->Belt.Array.size {
        None
      } else {
        Some(events)
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

  let form_footer = {
    let priority = "tertiary"
    <Dsfr.ButtonsGroup
      inlineLayoutWhen="always"
      className="text-left"
      buttonsEquisized=true
      buttonsSize="medium"
      alignment="center"
      buttons=[
        {
          children: `Réinitialiser le formulaire`->React.string,
          onClick: _ => {
            Console.debug("Resetting form data")
            setFormData(_ => initialData)
          },
          iconId: "fr-icon-refresh-line",
          priority,
        },
        {
          children: `Exporter les données au format JSON`->React.string,
          onClick: _ => {
            let data_str = Js.Json.stringify(formData->Belt.Option.getWithDefault(Js.Json.null))
            downloadJSONstring(data_str)
          },
          iconId: "fr-icon-upload-line",
          priority,
        },
        {
          children: <>
            <input
              className="hidden w-100" id="file-upload" type_="file" onChange={fileChangeHandler}
            />
            <label htmlFor="file-upload" className="cursor-pointer">
              {`Importer les données au format JSON `->React.string}
            </label>
            <p />
          </>,
          onClick: retrieveFileContents,
          iconId: "fr-icon-download-line",
          priority,
        },
        {
          children: {"Code source du programme"->React.string},
          onClick: {
            _ =>
              // TODO: the version should be linked to the version of the french-law
              currentPath->List.concat(list{`sources`, assetsVersion})->Nav.goToPath
          },
          iconId: "fr-icon-code-s-slash-line",
          priority,
        },
      ]
    />
  }

  let form_result =
    <Dsfr.CallOut>
      {switch formData {
      | None => `En attente de la confirmation du formulaire...`->React.string
      | Some(formData) =>
        try {
          <div className="flex flex-col">
            <div>
              {formInfos.resultLabel->React.string}
              {" = "->React.string}
              {formInfos.computeAndPrintResult(formData)}
            </div>
            <Dsfr.Button
              onClick={_ => {
                switch schemaState {
                | Some(schema) => {
                    let doc = CatalaExplain.generate(
                      // NOTE(@EmileRolley): we assume that the events exist,
                      // because we have a result.
                      ~events=eventsOpt->Option.getExn,
                      ~userInputs=formData,
                      ~schema,
                      ~opts={
                        title: `Calcul des ${formInfos.name}`,
                        // Contains an explicatory text about the computation and the catala program etc...
                        description: `Explication du détail des étapes de calcul établissant l'éligibilité et le montant des ${formInfos.name} pour votre demande`,
                        creator: `catala-dsfr / assets ${assetsVersion}`,
                        keysToIgnore: formInfos.webAssets.keysToIgnore,
                        selectedOutput: formInfos.webAssets.selectedOutput,
                        sourcesURL: `${Constants.host}/${formInfos.url}/sources/${assetsVersion}`,
                      },
                    )

                    doc
                    ->Docx.Packer.toBlob
                    ->Promise.thenResolve(blob => {
                      FileSaver.saveAs(
                        blob,
                        `explication-decision-${formInfos.name->String.replaceRegExp(
                            %re("/\s/g"),
                            "_",
                          )}.docx`,
                      )
                    })
                    ->ignore
                  }
                | None => Console.error("Missing schema to generate the doc")
                }
              }}
              iconPosition="left"
              iconId="fr-icon-newspaper-line"
              priority="secondary">
              {`Télécharger une explication du calcul`->React.string}
            </Dsfr.Button>
          </div>
        } catch {
        | err =>
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
      }}
    </Dsfr.CallOut>

  <>
    <div className="fr-container--fluid">
      <div className="fr-grid-row fr-grid-row--gutters fr-grid-row--center">
        <Dsfr.Notice
          title={`Les données collectées par ce formulaire ne sont envoyées nulle part, et sont gérées uniquement par votre navigateur internet. \
            Les données sont traitées localement par un programme Javascript qui a été transmis avec le reste de ce site Internet. \
            Ainsi, ce site ne collecte aucune donnée de ses utilisateurs.`}
          isClosable=true
        />
        <div className="fr-col">
          {switch (schemaState, uiSchemaState) {
          | (Some(schema), Some(uiSchema)) =>
            <React.Suspense fallback={Spinners.loader}>
              <RjsfFormDsfrLazy
                schema
                uiSchema
                formData={formData->Belt.Option.getWithDefault(Js.Json.null)}
                onSubmit={t => {
                  setFormData(_ => {
                    let formData = t->Js.Dict.get("formData")
                    switch (formInfos.formDataPostProcessing, formData) {
                    | (Some(f), Some(formData)) => {
                        let newFormData = f(formData)
                        Some(newFormData)
                      }
                    | _ => formData
                    }
                  })
                }}
              />
            </React.Suspense>
          | _ => Spinners.loader
          }}
        </div>
        <div
          className="w-full fr-m-1w border-2 border-solid rounded-full border-[var(--border-default-grey)]"
        />
        <div className="fr-col"> form_result </div>
      </div>
      form_footer
    </div>
  </>
}
