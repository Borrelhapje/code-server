FROM codercom/code-server:4.16.1-bullseye
USER root
RUN apt-get update \
    && apt-get install --yes \
    default-jdk \
    nodejs \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

RUN mkdir /opt/gradle \
    && cd /opt/gradle \
    && curl -sSL "https://services.gradle.org/distributions/gradle-8.3-bin.zip" -o gradle.zip \
    && jar xf gradle.zip \
    && chmod +x /opt/gradle/gradle-8.3/bin/gradle \
    && rm gradle.zip

RUN curl -sSL "https://go.dev/dl/go1.21.1.linux-amd64.tar.gz" -o go.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz \
    && rm go.tar.gz

RUN curl -sSL "https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz" -o node.tar.xz \
    && tar -C /usr/local -xf node.tar.xz \
    && rm node.tar.xz

ENV PATH=/opt/gradle/gradle-8.3/bin:/usr/local/go/bin:/usr/local/node-v18.17.1-linux-x64/bin:$PATH
USER 1000
