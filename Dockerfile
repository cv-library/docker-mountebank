FROM mhart/alpine-node:12

RUN ["npm", "install", "-g", "mountebank@2.1.0", "--production"]

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

# TODO File a PR
# Based on https://github.com/ReachFive/fake-smtp-server/pull/10
RUN sed -i 14imaxAllowedUnauthenticatedCommands:2000, \
    /usr/lib/node_modules/mountebank/src/models/smtp/smtpServer.js

FROM mhart/alpine-node:slim-12

COPY --from=0 /usr/lib/node_modules/mountebank /usr

ENTRYPOINT ["mb", "--mock"]
