FROM mcr.microsoft.com/dotnet/core/sdk:3.0

# DOCKER
RUN apt-get update
RUN apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update    
RUN apt-get -y install docker-ce docker-ce-cli containerd.io

# RUN useradd -ou 0 -g 0 builder-user
# RUN usermod -aG docker builder-user

# USER builder-user

RUN sudo docker run hello-world

# # DOCKER COMPOSE
# ENV DOCKER_COMPOSE_VERSION 1.24.1

# RUN curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# RUN chmod +x /usr/local/bin/docker-compose

# # NODE
# ENV NODE_VERSION 12.13.0
# ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz
# # https://nodejs.org/dist/v12.13.0/SHASUMS256.txt.asc
# ENV NODE_DOWNLOAD_SHA c69671c89d0faa47b64bd5f37079e4480852857a9a9366ee86cdd8bc9670074a

# RUN curl -SL "$NODE_DOWNLOAD_URL" --output nodejs.tar.gz \
#     && echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
#     && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
#     && rm nodejs.tar.gz \
#     && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# # YARN
# ENV YARN_VERSION 1.19.1

# RUN set -ex \
#   && wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --import \
#   && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
#   && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
#   && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
#   && mkdir -p /opt/yarn \
#   && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
#   && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
#   && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
#   && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz

WORKDIR /