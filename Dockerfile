FROM codercom/code-server:4.93.1-debian
USER root
RUN apt-get update \
    && apt-get install --yes \
    default-jdk \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

ENV GRADLE_VERSION=8.10.2

RUN mkdir /opt/gradle \
    && cd /opt/gradle \
    && curl -sSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o gradle.zip \
    && jar xf gradle.zip \
    && chmod +x /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle \
    && rm gradle.zip \
    && ln -s /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/

ENV GO_VERSION=1.21.5

RUN curl -sSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -o go.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz \
    && rm go.tar.gz \
    && ln -s /usr/local/go/bin/* /usr/local/bin/

ENV NODE_VERSION=20.17.0

RUN curl -sSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" -o node.tar.xz \
    && tar -C /usr/local -xf node.tar.xz \
    && rm node.tar.xz \
    && ln -s /usr/local/node-v${NODE_VERSION}-linux-x64/bin/* /usr/local/bin/

USER 1000
