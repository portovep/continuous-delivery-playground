# Lab 5: Continuous delivery - Deploying the app

The goal of this lab is to show you how you could automate the deployment of the app to a specific environment, e.g. staging or production.

> Note: this lab builds upon the results of the previous labs

## Adding a deployment stage to our continuous deployment pipeline

In previous stages of the pipeline we make sure the latest changes were integrated, the test were passing and the application is built and package. That gives us enough confident that we can deploy the latest version of the application to an environment.

Think about it, when do the latest code changes start delivering value? Is it when they are tested and the application is built or is it when they are deployed and released to the end users?

This stage of the pipeline is a bit more complicated. So far we were running commands only in the Github Actions worker machines. To automate a deployment we need to trigger an action in an external service, the one providing the deployment environment. We need to authenticate with the service where we will deploy our app.

For the scope of this tutorial, we will use Vercel. You can think of Vercel like a free server where you can expose your app to real users. If you don't have a Vercel account, it is fine! No worries. You can go for option 1 in this lab where we simulate a deployment.

> "Deploy the same way to every environment—including development. This way, we test the deployment process many, many times before it gets to production, and again, we can eliminate it as the source of any problems." -- by [continuousdelivery.com](https://continuousdelivery.com/implementing/patterns/)

## Option 1: Let's simulate a deployment

Let's start by adding a new build tasks to our package.json file. This task automates the process of performing a deployment to a specific environment. Your script section in the package.json file should look like:

```json
"scripts": {
  "dev": "next dev",
  "build": "next build",
  "start": "next start",
  "test:unit": "jest --ci",
  "deploy:simulate": "../scripts/simulate-deployment.sh"
},
```

We added a new npm task, deploy:simulate, that calls a script that simulates a deployment and tells when the deployment is completed. Let's try to execute the automated deployment process locally and see what happens.

```bash
cd modern-web-app
npm run deploy:simulate -- production
```

So far so good, we automated our deployment process so that we can run it from our local environment. Next step is to perform the automated deployment as part of the pipeline. Lets add a new job that allow us to deploy our modern web app to an environment that we will call production. Lets add a new job:

```yaml
jobs:
    [....]
    deploy-prod:
        name: Deploy to prod
        needs: build
        runs-on: ubuntu-latest
        steps:
            - name: Checkout code
              uses: actions/checkout@v2
            - name: Deploy with Node.js ${{ env.NODE_VERSION }}
              uses: actions/setup-node@v1
              with:
                  node-version: ${{ env.NODE_VERSION }}
            - name: Download build artifact
              uses: actions/download-artifact@v3
              with:
                name: modern-web-app-${{ github.sha }}
                path: artifact_to_deploy
            - name: Deploy to prod environment
              run: |
               npm run deploy:simulate -- production
```

### Let's test our new pipeline stage

Once the changes are commited and pushed, the pipeline should run automatically as it is especified to run on push.

```bash
git add .
git commit -m "Add deployment stage to the CI/CD pipeline"
git push
```

## Option 2: Let's perform a real deployment (WIP)

Lets add a new job that allow us to deploy our modern web app to an environment that we will call production.

```yaml
jobs:
    [....]
    deploy-prod:
        name: Deploy to prod
        needs: check-performance
        runs-on: ubuntu-latest
        if: github.ref == 'refs/heads/main'

        steps:
            - name: Checkout code
              uses: actions/checkout@v2
            - name: Deploy with Node.js ${{ env.NODE_VERSION }}
              uses: actions/setup-node@v1
              with:
                  node-version: ${{ env.NODE_VERSION }}
            - name: Deploy to prod environment
              run: |
                npm i -g vercel
                vercel --token "$VERCEL_TOKEN" --prod
              env:
                VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
                VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
                VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
```

## Useful Theory

[What are the differences between continuous integration vs. delivery vs. deployment?](https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment)

## Lab checklist

- [x] Read the instructions
- [ ] Add the deploy:simulate tasks in the NPM scripts declaration
- [ ] Add the automated deployment job to the CD pipeline
- [ ] Push the changes and check the pipeline logs in the Actions tab
- [ ] Answer this question: Is the pipeline implementing continuous delivery or continuous deployment?
