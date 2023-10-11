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

> ℹ️ You need to have `rsync` installed to copy web assets from the
> `catala-web-assets` node package.

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
