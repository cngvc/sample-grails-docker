FROM openjdk:8-jre-alpine as init

RUN apk --no-cache add bash curl wget unzip zip

ENV GRAILS_VERSION 3.3.1

RUN curl -s https://get.sdkman.io | bash

RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install grails $GRAILS_VERSION && grails --version"

ENV SDKMAN_DIR=/root/.sdkman

ENV GRAILS_HOME="$SDKMAN_DIR/candidates/grails/current"

ENV PATH="$GRAILS_HOME/bin:$PATH"

RUN echo 

WORKDIR /app

COPY . ./

ARG mysql_url

ENV MYSQL_URL $mysql_url

ENV MYSQL_USERNAME root

ENV MYSQL_PASSWORD root

EXPOSE 8080

RUN grails dependency-report

CMD ["grails", "run-app"] 