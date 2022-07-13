# Lab 3: Continuous integration - Testing the app

The goal of this lab is to create the first stage in our CD pipeline, the test step. We will use what we learnt in lab 2 and replace our hello world pipeline for something more useful.

## Adding a testing stage to our continuous integration process

Given that our application code is not in the root folder, we need to tell GH Actions where to run the commands from. Lets specify that the NPM commands needs to be run from the modern-web-app directory.

```yml
defaults:
  run:
    working-directory: modern-web-app
```

We also need to tell one of the GH Actions we will use wich version of Node.js we need. We can do that by declaring an environment variable that we can reference later on.

```yml
env:
  NODE_VERSION: "14.17"
```

The next step is to simply specify the test job and add it to the pipeline definition:

```yml
jobs:
  test:
    name: Test
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Setup Node.js ${{ env.NODE_VERSION }}
        uses: actions/setup-node@v1
        with:
          node-version: ${{ env.NODE_VERSION }}
      - name: Run unit tests
        run: |
          npm ci
          npm run test:unit
```

### Pipeline Concepts

- **_env_**: To specify environment variables that can be reused across the pipeline definition.
- **_working-directory_**: To change the directory from which GH Actions will execute the run commands
- **_uses_**: To sepecify already defined GH Actions. You can think of these as reusable actions that you can incorporate in your pipeline, e.g. checkout, setup-node...
- **_with_**: To pass parameters to already defined GH Actions.

### Let's test our new pipeline stage

Once the changes are commited and pushed, the pipeline should run automatically as it is especified to run on push.

```bash
git add .
git commit -m "Add test stage to the CI pipeline"
git push
```

## Useful Theory

[What is continuous testing?](https://continuousdelivery.com/foundations/test-automation/)
Continuous testing is the practice of running many different types of tests—both manual and automated—continually throughout the delivery process with the goal of finding problems as soon as possible.

[What is test automation?](https://www.atlassian.com/devops/devops-tools/test-automation)
Test automation is the practices of automating test tasks to make sure the application is ready to be deployed and it meets the pre-defined quality standards.

## Lab checklist

- [x] Read the instructions
- [ ] Replace the hello world job with the new test job
- [ ] Push the changes and check the pipeline execution in the Actions tab
- [ ] Break the tests, commit and push the changes. Check what happens.
