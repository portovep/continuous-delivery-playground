# Lab 2: Creating a hello world pipeline

### GitHub Actions to create a CI/CD pipeline

The goal of this tutorial is to understand the basic use of github actions creating a hello world pipeline.

> Note: On the last lab you entered the modern-web-app directory, go back to the root before continuing with the instructions.

The first step is to create a github workflow, create the following folder structure:

```
   mkdir .github/
   mkdir .github/workflows/
```

Navigate to the folder we just created

```
   cd .github/workflows/
```

Now we create a workflow inside the workflows folder.

```
touch .github/workflows/pipeline.yml
```

The next step is to add the pipeline definition in the file we just created.

```yml
name: CI/CD Pipeline

on: push
jobs:
  hello-world:
    runs-on: ubuntu-latest
    steps:
      - name: Hello World step
        run: echo "Hello World!"
```

### Pipeline Core Concepts

- **_Name_**: This is just specifying a name for the workflow.
- **_On_**: The on command is used to specify an event that will trigger the workflow, this event can be push, pull_request, etc.
- **_Jobs_**: Here we are specifying the job we want to run, in this case, we are setting up a build job.
- **_Runs-on_**: is specifying the OS you want your workflow to run on.
- **_Steps_**: Steps just indicate the various steps you want to run on that job.

### Let's test our Pipeline

Once the changes are commited the pipeline should run automatically as especified to run on push.

```bash
git add .
git commit -m "Add workflow file"
git push
```

## Useful Theory

[What is a pipeline?](https://www.atlassian.com/devops/devops-tools/devops-pipeline#:~:text=A%20DevOps%20pipeline%20is%20a,code%20to%20a%20production%20environment.)
a pipeline is a system of automated processes designed to quickly and accurately move new code additions and updates from version control to production.

[what is continous integration?](https://martinfowler.com/articles/continuousIntegration.html#:~:text=Continuous%20Integration%20is%20a%20software,to%20multiple%20integrations%20per%20day.)
Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day.

[what is continous delivery?](https://aws.amazon.com/devops/continuous-delivery/?nc1=h_ls)
is a software development practice where code changes are automatically prepared for a release to production.
With continuous delivery, every code change is built, tested, and then pushed to a non-production testing or staging environment.
Continuous delivery automates the entire software release process.

[what is github actions?](https://resources.github.com/downloads/What-is-GitHub.Actions_.Benefits-and-examples.pdf)
GitHub Actions brings automation directly into the software development lifecycle on GitHub via event-driven triggers. These
triggers are specified events that can range from creating a pull request to building a new brand in a repository.

[Github Actions Docs](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions?learn=getting_started)

## Lab checklist

- [x] Read the instructions
- [ ] Create folder structure
- [ ] Create a github workflow
- [ ] Push the changes and check the pipeline execution in the Actions tab
