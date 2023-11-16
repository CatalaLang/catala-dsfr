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

TODO

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
