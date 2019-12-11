FROM mhart/alpine-node:13

RUN ["npm", "install", "-g", "mountebank@2.1.2", "--production"]

RUN find /usr/lib/node_modules/mountebank \
    \( -name '*.md'          \
    -o -name '*akefile'      \
    -o -name appveyor.yml    \
    -o -name changelog       \
    -o -name CONTRIBUTORS    \
    -o -name coverage        \
    -o -name '.eslint*'      \
    -o -name example         \
    -o -name examples        \
    -o -name '*LICENSE*'     \
    -o -name License         \
    -o -name license         \
    -o -name man             \
    -o -name .npmignore      \
    -o -name 'README*'       \
    -o -name readme.markdown \
    -o -name samples         \
    -o -name screenshots     \
    -o -name 'test*'         \
    -o -name .travis.yml     \
    \) -exec rm -fr {} +

# Bump maxAllowedUnauthenticatedCommands
RUN sed -i 's/maxAllowedUnauthenticatedCommands: 1000/maxAllowedUnauthenticatedCommands: 2000/' \
    /usr/lib/node_modules/mountebank/src/models/smtp/smtpServer.js

FROM mhart/alpine-node:slim-13

COPY --from=0 /usr/lib/node_modules/mountebank /usr

ENTRYPOINT ["mb", "--mock"]
