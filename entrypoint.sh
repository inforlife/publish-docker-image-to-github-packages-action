#!/bin/bash
set -e

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Password not found. Add password: \${{ secrets.GITHUB_TOKEN }} to the workflow file."
  exit 1
fi

if [ -z "${INPUT_SLACK_TOKEN}" ]; then
  echo "Slack token not found. Add slack_token: \${{ secrets.SLACK_TOKEN }} to the workflow file."
  echo "Make also sure to have added the token to the repo's secrets."
  exit 1
fi

DOCKERTAG=${GITHUB_REF:10}
REPO=$(echo ${GITHUB_REPOSITORY} | cut -d'/' -f2-)

echo ${INPUT_PASSWORD} | docker login docker.pkg.github.com -u inforlife --password-stdin
docker build -t ${DOCKERTAG} .
docker tag ${DOCKERTAG} docker.pkg.github.com/inforlife/registry/${REPO}:${DOCKERTAG}
docker push docker.pkg.github.com/inforlife/registry/${REPO}:${DOCKERTAG}
docker logout

curl -X POST -H 'Content-type: application/json' --data '{"text":"The image '${REPO}':'${DOCKERTAG}' has been published to the InfoRLife registry."}' https://hooks.slack.com/services/${INPUT_SLACK_TOKEN}
