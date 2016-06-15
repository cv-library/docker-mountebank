# MB fails under Node 6 - https://github.com/bbyars/mountebank/commit/d8f16
FROM mhart/alpine-node:5.10.1

RUN npm install -g mountebank@1.5.1 --production

ENTRYPOINT ["mb", "--mock"]
