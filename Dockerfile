FROM philipssoftware/node:lts

LABEL maintainer="Jeroen Knoops <jeroen.knoops@philips.com>"
LABEL maintainer="Brend Smits <brend.smits@philips.com>"

WORKDIR /app
COPY . /app

RUN yarn global remove lerna && yarn cache clean

RUN git clone https://github.com/philips-forks/repolinter.git 
RUN cd repolinter && git checkout -f feature/specify-branches && npm i --production && cd ..

ENTRYPOINT ["/app/bin/loop.sh"]
