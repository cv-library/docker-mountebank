FROM mhart/alpine-node:7.10.0

RUN ["npm", "install", "-g", "mountebank@1.10.0", "--production"]

ENTRYPOINT ["mb", "--mock"]
