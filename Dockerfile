FROM docker:19.03.5

LABEL "com.github.actions.name"="Build and Publish Docker Image to GitHub Packages"
LABEL "com.github.actions.description"="Build Docker Image from the latest release and pushes it to GitHub Packages"
LABEL "com.github.actions.icon"="anchor"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/inforlife/publish-docker-image-to-github-packages-action/"
LABEL "maintainer"="The Software Development Team at InfoRLife SA <dev@inforlife.ch>"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache bash git curl

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
