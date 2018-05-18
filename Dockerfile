FROM mhart/alpine-node:10.1.0

RUN ["npm", "install", "-g", "mountebank@1.14.1", "--production"]

RUN find /usr/lib/node_modules/mountebank \
    \( -name '*.md'        \
    -o -name '*akefile'    \
    -o -name changelog     \
    -o -name examples      \
    -o -name '*LICENSE*'   \
    -o -name license       \
    -o -name 'README*'     \
    -o -name samples       \
    -o -name screenshots   \
    -o -name 'test*'       \
    \) -exec rm -fr {} +

FROM mhart/alpine-node:base-10.1.0

COPY --from=0 /usr/lib/node_modules/mountebank /usr

ENTRYPOINT ["mb", "--mock"]
