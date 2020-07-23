#!/bin/bash
set -e

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Password not found. Add password: \${{ secrets.INFORLIFE_ACCESS_TOKEN }} to the workflow file."
  exit 1
fi

if [ -z "${INPUT_SLACK_TOKEN}" ]; then
  echo "Slack token not found. Add slack_token: \${{ secrets.SLACK_TOKEN }} to the workflow file."
  echo "Make also sure to have added the token to the repo's secrets."
  exit 1
fi

RELEASE_TAG=${GITHUB_REF:10}
REPO=$(echo ${GITHUB_REPOSITORY} | cut -d'/' -f2-)

docker build --build-arg RELEASE_TAG=${RELEASE_TAG} -t image .
echo ${INPUT_PASSWORD} | docker login docker.pkg.github.com -u inforlife --password-stdin
docker tag image docker.pkg.github.com/inforlife/registry/${REPO}:${RELEASE_TAG}
docker push docker.pkg.github.com/inforlife/registry/${REPO}:${RELEASE_TAG}
docker logout

curl -X POST -H 'Content-type: application/json' --data '{"text":"The image '${REPO}':'${RELEASE_TAG}' has been published to the InfoRLife registry."}' https://hooks.slack.com/services/${INPUT_SLACK_TOKEN}
