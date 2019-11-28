#!/bin/bash
set -e

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Password not found. Add password: \${{ secrets.GITHUB_TOKEN }} to the workflow file."
  exit 1
fi

TAGPARTS=($(echo $(echo ${GITHUB_REF:10}) | tr "." "\n"))

if [ -z "${TAGPARTS[2]}" ]; then
 TAGPARTS[2]="production"
fi

DOCKERTAG="${TAGPARTS[0]}.${TAGPARTS[1]}:${TAGPARTS[2]}"

echo ${INPUT_PASSWORD} | docker login docker.pkg.github.com -u $(echo ${GITHUB_REPOSITORY} | cut -d'/' -f01) --password-stdin
docker build -t ${DOCKERTAG} .
docker tag ${DOCKERTAG} docker.pkg.github.com/${GITHUB_REPOSITORY}/${DOCKERTAG}
docker push docker.pkg.github.com/${GITHUB_REPOSITORY}/${DOCKERTAG}
docker logout
