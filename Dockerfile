FROM philipssoftware/node:lts

LABEL maintainer="Jeroen Knoops <jeroen.knoops@philips.com>"
LABEL maintainer="Brend Smits <brend.smits@philips.com>"

RUN ls -all

WORKDIR /app
COPY . /app

RUN ls -all

# Add REPO en TAGS info
ADD REPO .
ADD TAGS .

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]