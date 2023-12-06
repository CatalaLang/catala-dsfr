<div align="center">
  <h3 align="center">
	<big>Catala DFSR</big>
  </h3>
  <p align="center">
   <a href="https://github.com/CatalaLang/catala-dsfr/issues">Report Bug</a>
   •
   <a href="https://code.gouv.fr/fr/explicabilite/catala/">Website</a>
  </p>

Source code for web demonstration about the explainability of Catala programs.

</div>

---

This project is built on top of the following libraries:

- [`@catala-lang/french-law`](https://github.com/CatalaLang/catala/tree/master/french_law/js)
- [`@catala-lang/rescript-catala`](https://github.com/CatalaLang/catala/tree/master/runtimes/rescript)
- [`@catala-lang/catala-explain`](https://github.com/CatalaLang/catala-explain)
- [`@catala-lang/catala-web-assets`](https://github.com/CatalaLang/catala-web-assets)
- [`@codegouvfr/react-dsfr`](https://github.com/codegouvfr/react-dsfr/)

## Local dev

```
# Install dependencies
yarn

# Start a local dev server
yarn dev
```

> [!CAUTION]
> When adding modifications to the Rescript files, if you start seeing errors
> like that in your `yarn dev` output:
>
> ```
> 14:28:30 [vite] hmr invalidate /src/components/Form.bs.js Could not Fast Refresh.
> ```
> 
> That means that the fast reload isn't working properly. To avoid that, each
> ReScript file must export only one React component. You can hide internal
> code by providing an interface file that only exports the component you want
> to use.

### Using local packages

If you want to use one of the `@catala-lang` packages from your local machine
instead of the published version, you can use `yarn link` to link them to this
project.

```
# In the library you want to link
yarn link

# In this project
yarn link @catala-lang/<library-name>
```

> [!IMPORTANT]
>
> But then some shenanigans will appear. First, there might be duplicate
> dependencies between `catala-dsfr` and the linked dependencies. These duplicates
> will show as error messages so you know which they are. To remove the dependency
> duplication, you should link the version of the duplicate dependency in
> `catala-dsfr/node_modules/<duplicate-library-name>` and make sure
> `@catala-lang/<library-name>` uses it with `yarn link <duplicate-library-name>`
> in the local folder of `@catala-lang/<library-name>`.
>
> Now that the links are OK, you have to tell `vite` to watch for the changes in
> the dependencies to have reloading work. For that, follow the instructions to
> modify `vite.config.ts` in `catala-dsfr`
> [here](https://vitejs.dev/config/server-options.html#server-watch). At last,
> don't forget to run `yarn watch` in the local folder of
> `@catala-lang/<library-name>`, so that the modifications in the Rescript files
> are watched and compiled to modifications to JS files that `vite` can pick up.

## Versioned assets

Multiple versions of
[@catala-lang/catala-web-assets](https://github.com/CatalaLang/catala-web-assets)
and [@catala-lang/french-law](https://github.com/CatalaLang/french-law) are
used in this project.

In the `assets-versions.json` file is defined the list of versions available.
Each version is defined by a pair of versions for each package (one for the web
assets and one for the french law library) and named with the corresponding
date.

### To add a new version

To add a new version of the assets, you need to use the [yarn
aliases](https://classic.yarnpkg.com/en/docs/cli/add#toc-yarn-add-alias):

```bash
# For @catala-lang/catala-web-assets
yarn add @catala-lang/catala-web-assets-<latest-version>@npm:@catala-lang/catala-web-assets@<latest-version>

# For @catala-lang/french-law
yarn add @catala-lang/french-law-<latest-version>@npm:@catala-lang/french-law@<latest-version>
```

> [!TIP]
> The latest version of the `@catala-lang/catala-web-assets` package and the
> `@catala-lang/french-law` package are automatically updated with the
> `./update-assets.sh` script run in `postinstall` in `package.json`.

> [!IMPORTANT]
> For now, if a new version of one of the packages is added, you need to **manually** update
> the `assets-versions.json` file with the new version.
>
> ```diff
> {
>   "available": [
> +   {
> +    "name": "<date>",
> +    "catala-web-assets": "<latest-version>",
> +    "french-law": "<latest-version>"
> +  },
>   ]
> }
> ```

## Build for production and deploy

### To test before deploy

```
# Build for production
yarn build

# Locally preview the production build
yarn serve
```

### To deploy

```
# Build for production and rsync files to the <destination> (could be a ssh address)
yarn deploy <destination>
```

## Sponsors

This library has been developed during a research project funded by the
[_mission logiciels libres et communs numériques_](https://www.code.gouv.fr/)
of the [_direction interministérielle du
numérique_](https://www.numerique.gouv.fr/) in collaboration with the
[Catala](https://catala-lang.org/) project.
