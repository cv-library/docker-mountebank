FROM mhart/alpine-node:11

RUN ["npm", "install", "-g", "mountebank@1.14.1", "--production"]

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

FROM mhart/alpine-node:base-11

COPY --from=0 /usr/lib/node_modules/mountebank /usr

ENTRYPOINT ["mb", "--mock"]
