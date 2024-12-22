FROM alpine:3.20

# replace the mirror
RUN echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.20/main" > /etc/apk/repositories
RUN echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.20/community" >> /etc/apk/repositories
RUN apk update

RUN apk add alpine-sdk atools

WORKDIR /work

RUN echo "PACKAGER_PRIVKEY=/keys/key.rsa" >> /etc/abuild.conf

# switch to non-root user
RUN adduser -D builder
RUN addgroup builder abuild
USER builder

ENTRYPOINT ["abuild", "-r"]