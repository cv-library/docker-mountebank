FROM mhart/alpine-node:6.5.0

RUN ["npm", "install", "-g", "mountebank@1.6.0", "--production"]

ENTRYPOINT ["mb", "--mock"]
