# Next.js Template

[![CI](https://github.com/peteoshea/nextjs-template/workflows/CI/badge.svg)](https://github.com/peteoshea/nextjs-template/actions)

This is based on the [with-typescript-eslint-jest](https://github.com/vercel/next.js/tree/canary/examples/with-typescript-eslint-jest) Next.js example project.

Bootstrap a developer-friendly NextJS app configured with:

- [Typescript](https://www.typescriptlang.org/)
- Linting with [ESLint](https://eslint.org/)
- Formatting with [Prettier](https://prettier.io/)
- Linting, typechecking and formatting on by default using [`husky`](https://github.com/typicode/husky) for commit hooks
- Testing with [Jest](https://jestjs.io/) and [`react-testing-library`](https://testing-library.com/docs/react-testing-library/intro)

It also includes my [base-scripts](https://github.com/peteoshea/base-template) to make it easy to get started with this project without having to know any of the underlying tools or how to use them.

## How to use

There is no special one-off setup required for this project to you can simply run the server [bash](script/server) or [PowerShell](script/server.ps1) script:

```bash
$ ./script/server
```
or
```PowerShell
> .\script\server.ps1
```

You should now be running in development mode on [http://localhost:3000](http://localhost:3000).

This runs `next dev` to get start in development mode rather than `next start` which start a production server. Note that `next` is installed as a node package locally so the `next` command isn't necessarily available directly from the command line so it is actually called using `npm run dev`.
