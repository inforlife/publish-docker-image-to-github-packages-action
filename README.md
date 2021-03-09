# Publish Docker Image To GitHub Packages

## [![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/) - This action is no longer maintained, use https://github.com/inforlife/publish-docker-image-to-github-container-registry-action instead.

A GitHub Action which creates, from the latest release (git tag), a Docker Image and pushes it to GitHub Packages.

## Usage
Add the following to `.github/workflows/publish-image.yml`

```yaml
name: Publish Docker Image
on:
  release:
    types: [published]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Publish to GitHub Packages
      uses: inforlife/publish-docker-image-to-github-packages-action@v3
      with:
        password: ${{ secrets.INFORLIFE_ACCESS_TOKEN }}
        slack_token: ${{ secrets.SLACK_TOKEN }}
```

## Secrets
- **The `INFORLIFE_ACCESS_TOKEN` must be created and added to the Repo's secrets via GitHub UI.** The token should be unique for the repo and have `read:packages, repo, write:packages` permissions.
- **The `SLACK_TOKEN` must be added to the Repo's secrets via GitHub UI.**

## Docker image
This action creates the package `docker.pkg.github.com/inforlife/registry/<REPO>:<RELEASE_TAG>`.

## Slack Notification
This action posts the message `The image <REPO>:<RELEASE_TAG> has been published to InfoRLife's registry.` to the `github-packages` Slack channel.
