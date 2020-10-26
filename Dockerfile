FROM mcr.microsoft.com/dotnet/sdk:5.0

ENV NODE_VERSION 14.14.0
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz
# https://nodejs.org/dist/$NODE_VERSION/SHASUMS256.txt.asc
ENV NODE_DOWNLOAD_SHA 438cc26853b17f4aad79fb441f6dbcc1128aff9ffcd0c132ae044259f96ff6a8

ENV DOCKER_COMPOSE_VERSION 1.27.4
ENV YARN_VERSION 1.22.10

# # DOCKER
# RUN apt-get update
# RUN apt-get -y install \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common

# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# RUN apt-key fingerprint 0EBFCD88
# RUN add-apt-repository \
#     "deb [arch=amd64] https://download.docker.com/linux/debian \
#     $(lsb_release -cs) \
#     stable"

# RUN apt-get update
# RUN apt-get -y install docker-ce docker-ce-cli containerd.io

# RUN useradd -ou 0 -g 0 builder-user
# RUN usermod -aG docker builder-user
# RUN service docker restart

# RUN docker run hello-world

# # DOCKER COMPOSE

# RUN curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# RUN chmod +x /usr/local/bin/docker-compose

# NODE

RUN curl -SL "$NODE_DOWNLOAD_URL" --output nodejs.tar.gz && \
    echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - && \
    tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 && \
    rm nodejs.tar.gz \
    ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN apt-get update && apt-get install -y gnupg2

# YARN
RUN curl -L -o yarn.tar.gz "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" && \
    sudo tar -xzf yarn.tar.gz -C /opt/ && \
    rm yarn.tar.gz && \
    sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
    sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg

RUN node --version
RUN yarn --version

WORKDIR /
