FROM philipssoftware/node:lts

LABEL maintainer="Jeroen Knoops <jeroen.knoops@philips.com>"
LABEL maintainer="Brend Smits <brend.smits@philips.com>"

WORKDIR /app
COPY . /app

RUN git clone https://github.com/philips-labs/repolinter.git && cd repolinter && npm i && cd ..

WORKDIR /cc
RUN git clone https://github.com/philips-labs/continuous-compliance-action.git && cd continuous-compliance-action

ENTRYPOINT ["/cc/continuous-compliance-action/bin/loop.sh"]