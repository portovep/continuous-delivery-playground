# Lab 1: Local development workflow

## Let's try our local development workflow

This tutorial uses NPM as a build tool. NPM allows you to define automated build tasks in the package.json file. In this file you can see some build tasks already defined:

```javascript
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test:unit": "jest --ci"
  }
```

To build the app, we can just simple tell npm to do so.

```sh
npm run build
```

Our team is very professional and has written some unit tests to make sure we can refactor the application if needed. Lets make sure all of them are passing:

```sh
npm run test:unit
```

If we want to deploy the app in the local environment in development mode, we can simple run:

```sh
npm run dev
```

and then open http://localhost:3000 to check our modern web app.

## Lab checklist

- [x] Read the instructions
- [ ] Build the application locally
- [ ] Run the unit tests
- [ ] Deploy the application locally in development mode
