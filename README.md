# Publish Docker Image To GitHub Packages

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
      uses: inforlife/publish-docker-image-to-github-packages-action@v1
      with:
        password: ${{ secrets.GITHUB_TOKEN }}
```
