# Lab 4: Continuous integration - Building and packaging the app

The goal of this lab is to show you how to add a stage in our pipeline to build and package the app.

> Note: this lab builds upon the results of the previous labs.

## Adding a build stage to our continuous integration process

In the previous stage of our pipeline we make sure the latest changes are integrated and the test are passing. The next step is to build and package new version of the application.

Lets add a new job call build with the following steps

```yaml
jobs:
    [....]
    build:
        name: Build
        runs-on: ubuntu-latest

        steps:
            - name: Checkout code
              uses: actions/checkout@v2
            - name: Setup Node.js ${{ env.NODE_VERSION }}
              uses: actions/setup-node@v1
              with:
                  node-version: ${{ env.NODE_VERSION }}
            - name: Build the application
              run: |
                npm ci
                npm run build
            - name: Upload artifacts
              uses: actions/upload-artifact@v3
              with:
                name: modern-web-app-v${{ github.github_sha }}}
                path: modern-web-app/.next/

```

As you can see, we added a step to build the application and its dependecies with NPM. Finally, we use the upload-artifact GH Action to upload a build artifact that contains the code of the application.

> "Only build packages once. We want to be sure the thing we’re deploying is the same thing we’ve tested throughout the deployment pipeline, so if a deployment fails we can eliminate the packages as the source of the failure." -- by [continuousdelivery.com](https://continuousdelivery.com/implementing/patterns/)

## Lab checklist

- [x] Read the instructions
- [ ] Add the build job to the CD workflow
- [ ] Push the changes and check the pipeline logs in the Actions tab
- [ ] Think about other tasks that could be automated as part of the build stage in the pipeline
