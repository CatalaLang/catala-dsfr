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
let downloadJSONstring: string => unit = %raw(`function(data) {
    const blob = new Blob([data],{type:'application/json'});
    const href = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = href;
    link.download = "data.json";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
`)

// Function to read a file and get its contents as string
let readFileAsJSON: (Js.Json.t, Js.Json.t => 'a) => unit = %raw(`function(file, callback) {
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
}
`)

/*
  Builds a React component from provided information.
*/
@react.component
let make = (~version: Versions.t, ~frenchLaw: FrenchLaw.t, ~formInfos: FormInfos.t) => {
  let currentPath = Nav.getCurrentURL().path
  let assetsVersion = version["catala-web-assets"]
  let webAssets = formInfos.getWebAssets(assetsVersion)

  let (formData, setFormData) = React.useState(_ => None)
  let (initialData, setInitialData) = React.useState(_ => None)
  let (schemaState, setSchemaState) = React.useState(_ => None)
  let (uiSchemaState, setUISchemaState) = React.useState(_ => None)
  let (eventsState, setEventsState) = React.useState(_ => None)
  let (formResult, setFormResult) = React.useState(_ => None)

  React.useEffect1(() => {
    (webAssets.schemaImport(), webAssets.uiSchemaImport())
    ->Promise.all2
    ->Promise.thenResolve(((schema, uiSchema)) => {
      setSchemaState(_ => Some(schema))
      setUISchemaState(_ => Some(uiSchema))
    })
    ->Promise.done
    None
  }, [webAssets])

  React.useEffect2(() => {
    switch (formData, webAssets.initialDataImport) {
    | (None, Some(init)) =>
      init()
      ->Promise.thenResolve(data => {
        setInitialData(_ => Some(data))
        setFormData(_ => Some(data))
      })
      ->Promise.done
    | _ => ()
    }
    None
  }, (webAssets.initialDataImport, formData))

  React.useEffect3(() => {
    setEventsState(_ => {
      let events = {
        try {frenchLaw.retrieveEventsSerialized()->CatalaRuntime.deserializedEvents} catch {
        | _ => []
        }
      }
      0 == events->Belt.Array.size ? None : Some(events)
    })
    None
  }, (formResult, setEventsState, frenchLaw))

  React.useEffect2(() => {
    switch formData {
    | Some(data) =>
      setFormResult(_ => {
        Some(formInfos.computeAndPrintResult(frenchLaw, data))
      })
    | None => setFormResult(_ => None)
    }
    None
  }, (formData, frenchLaw))

  let (uploadedFile, setUploadedFile) = React.useState(_ => {
    Js.Json.object_(Js.Dict.empty())
  })

  let fileChangeHandler = (_event: ReactEvent.Form.t) => {
    setUploadedFile(%raw(`_event.target.files[0]`))
  }

  let retrieveFileContents = _ => {
    if %raw(`uploadedFile instanceof File`) {
      readFileAsJSON(uploadedFile, form_data => {
        setFormData(_ => Some(form_data))
      })
    }
  }

  let formFooter = {
    let priority = "tertiary"
    <Dsfr.ButtonsGroup
      inlineLayoutWhen="always"
      className="text-left"
      buttonsEquisized=true
      buttonsSize="medium"
      alignment="center"
      buttons=[
        {
          children: React.string("Réinitialiser le formulaire"),
          onClick: _ => {
            Console.debug("Resetting form data")
            setFormData(_ => initialData)
          },
          iconId: "fr-icon-refresh-line",
          priority,
        },
        {
          children: React.string("Exporter les données au format JSON"),
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
              {React.string("Importer les données au format JSON")}
            </label>
            <p />
          </>,
          onClick: retrieveFileContents,
          iconId: "fr-icon-download-line",
          priority,
        },
        {
          children: {React.string("Code source du programme")},
          onClick: {
            _ => currentPath->List.concat(list{`sources`})->Nav.goToAbsolutePath
          },
          iconId: "fr-icon-code-s-slash-line",
          priority,
        },
      ]
    />
  }

  let formResult =
    <Dsfr.CallOut>
      {switch (formData, formResult) {
      | (Some(formData), Some(formResult)) =>
        try {
          <div className="flex flex-col">
            <div>
              {React.string(formInfos.resultLabel)}
              {React.string(" = ")}
              {formResult}
            </div>
            <Dsfr.Button
              onClick={_ => {
                switch (schemaState, eventsState) {
                | (Some(schema), Some(events)) => {
                    let doc = CatalaExplain.generate(
                      ~events,
                      ~userInputs=formData,
                      ~schema,
                      ~opts={
                        title: `Calcul des ${formInfos.name}`,
                        // Contains an explicatory text about the computation and the catala program etc...
                        description: `Explication du détail des étapes de calcul établissant l'éligibilité et le montant des ${formInfos.name} pour votre demande`,
                        creator: `${Constants.host} avec catala-web-assets@v${assetsVersion} et french-law@v${frenchLaw.version}`,
                        keysToIgnore: webAssets.keysToIgnore,
                        selectedOutput: webAssets.selectedOutput,
                        sourcesURL: `${Constants.host}/${formInfos.url}/${version["name"]}/sources/`,
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
                | (None, _) =>
                  Console.error("Missing schema to generate the document with catala-explain")
                | (_, None) =>
                  Console.error("Missing log events to generate the document with catala-explain")
                }
              }}
              iconPosition="left"
              iconId="fr-icon-newspaper-line"
              priority="secondary"
              disabled={Option.isNone(eventsState)}>
              {React.string("Télécharger une explication du calcul")}
            </Dsfr.Button>
          </div>
        } catch {
        | err =>
          <>
            {React.string("Erreur de calcul : ")}
            {err
            ->Js.Exn.asJsExn
            ->Belt.Option.map(Js.Exn.message)
            ->Belt.Option.getWithDefault(Some(""))
            ->Belt.Option.getWithDefault("unknwon error, please retry the computation")
            ->React.string}
          </>
        }
      | _ => React.string("En attente de la confirmation du formulaire...")
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
        <div className="fr-col"> formResult </div>
      </div>
      formFooter
    </div>
  </>
}
