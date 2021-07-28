FROM openjdk:8-jre-alpine as init

RUN apk --no-cache add bash curl tar unzip gzip zip

ENV GRAILS_VERSION 3.3.1

RUN curl -s https://get.sdkman.io | bash

RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install grails $GRAILS_VERSION"

ENV SDKMAN_DIR=/root/.sdkman

ENV GRAILS_HOME="$SDKMAN_DIR/candidates/grails/current"
ENV PATH="$GRAILS_HOME/bin:$PATH"

WORKDIR /app

COPY . .

RUN grails --version

CMD ["grails", "run-app"] 