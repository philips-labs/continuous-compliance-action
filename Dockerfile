FROM philipssoftware/node:lts

LABEL maintainer="Jeroen Knoops <jeroen.knoops@philips.com>"
LABEL maintainer="Brend Smits <brend.smits@philips.com>"

WORKDIR /app
COPY . /app

RUN git clone https://github.com/philips-labs/repolinter.git && cd repolinter && npm i && cd ..

ENTRYPOINT ["/app/repolinter/bin/repolinter.js"]

# FOR DEBUGGING IMAGE
# ENTRYPOINT ["tail", "-f", "/dev/null"]