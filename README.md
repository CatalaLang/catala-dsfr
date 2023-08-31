# catala-dsfr

A DSFR front-end for the
[`@catala-lang/catala-web-assets`](https://github.com/CatalaLang/catala-web-assets).

It uses [`@rescript/react`](https://github.com/rescript-lang/rescript-react/)
and custom ReScript bindings to
[`@codegouvfr/react-dsfr`](https://github.com/codegouvfr/react-dsfr/) which can
be found in
[`src/Dsfr.res`](https://github.com/CatalaLang/catala-dsfr/blob/main/src/Dsfr.res)

## Local dev

```
# Install dependencies
yarn

# Start a local dev server
yarn dev
```

> Note: you need to have `rsync` installed to copy web assets from the
> `catala-web-assets` node package.

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
