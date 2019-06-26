FROM openjdk:8-alpine
LABEL maintainer="Clairton Luz <clairton.c.l@gmail.com>"
WORKDIR /src
ARG RELEASE=3.3.0.1492

RUN apk add curl grep sed unzip nodejs npm

RUN cd /opt && \
    curl --insecure -o sonarscanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$RELEASE-linux.zip &&\
    ls -l && \
    pwd && \
    unzip sonarscanner.zip && \
    rm sonarscanner.zip && \
    rm -rf sonar-scanner-$RELEASE-linux/jre && \
    # ensure Sonar uses the provided Java for musl instead of a borked glibc one 
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner-$RELEASE-linux/bin/sonar-scanner

ENV SONAR_RUNNER_HOME=/opt/sonar-scanner-$RELEASE-linux
ENV PATH=$PATH:/opt/sonar-scanner-$RELEASE-linux/bin

CMD /bin/sh
