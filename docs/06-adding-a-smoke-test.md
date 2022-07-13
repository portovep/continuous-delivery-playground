# Lab 6 - Continuous delivery: Adding a smoke test

The goal of this lab is to show you how you could add a simple smoke test to your pipeline to make sure the application is still working after a deployment.

> Note: this lab builds upon the results of the previous labs

## Adding a smoke test to verify the deployment

For our case, the check is super simple, we will verify that the application loads and the user can see the home page.

> Note: If you choose to simulate a deployment in the previous step of the pipeline, you need to also simulate the smoke test.

Contents of the smoke test script:

```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

target_url=${1:-http://localhost}

echo "Running smoke test against: [${target_url}]"
echo "Smoke test started"
curl ${target_url}
echo "Smoke test completed successfully!"
```

To be able to run the smoke test script you have to define it in the package.json in the modern-web-app. We'll add the test:smoke task to point to our moke-test script.

```json
{
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test:unit": "jest --ci",
    "deploy:simulate": "../scripts/simulate-deployment.sh",
    "test:smoke": "../scripts/smoke-test.sh"
  }
  [...]
}
```

Lets add a new job to our pipeline that runs this script:

```yaml
jobs:
    [....]
    verify-deployment:
      name: Verify deployment
      needs: deploy-prod
      runs-on: ubuntu-latest
      steps:
          - name: Checkout code
            uses: actions/checkout@v2
          - name: Deploy with Node.js ${{ env.NODE_VERSION }}
            uses: actions/setup-node@v1
            with:
                node-version: ${{ env.NODE_VERSION }}
          - name: Run smoke test
            run: |
              npm run test:smoke -- https://google.es
```

## Useful Theory

[what are smoke tests?](https://circleci.com/blog/smoke-tests-in-cicd-pipelines/)
Smoke tests are designed to reveal these types of failures early by running test cases that cover the critical components and functionality of the application. They also ensure that the application will function as expected in a deployed scenario.

## Lab checklist

- [x] Read the instructions
- [ ] Add the smoke test job to the pipeline
- [ ] Push the changes and check the pipeline logs in the Actions tab
- [ ] Think about other ways to perform smoke tests rather than using curl
