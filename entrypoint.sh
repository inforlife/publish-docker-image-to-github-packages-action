#!/bin/bash
set -e

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Password not found. Add password: \${{ secrets.GITHUB_TOKEN }} to the workflow file."
  exit 1
fi

DOCKERTAG=${GITHUB_REF:10}
REPO=$(echo ${GITHUB_REPOSITORY} | cut -d'/' -f2-)

echo ${INPUT_PASSWORD} | docker login docker.pkg.github.com -u inforlife --password-stdin
docker build -t ${DOCKERTAG} .
docker tag ${DOCKERTAG} docker.pkg.github.com/inforlife/registry/${REPO}:${DOCKERTAG}
docker push docker.pkg.github.com/inforlife/registry/${REPO}:${DOCKERTAG}
docker logout
