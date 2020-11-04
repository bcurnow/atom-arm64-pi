from ubuntu:groovy

ARG USER_ID
ARG GROUP_ID
ARG ATOM_VERSION=v1.52.0
ARG NODE_VERSION=v12.16.0
ARG NODE_DISTRO=linux-arm64

# If the user specified isn't root (0), create a new user in the container that maps to that same uid and gid so that we can copy files back to the host system
RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    groupadd -g ${GROUP_ID} atom && \
    useradd -l -u ${USER_ID} -g atom atom && \
    install -d -m 0755 -o atom -g atom /home/atom && \
    mkdir -p /etc/sudoers.d && \
    echo "atom ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/atom-all-nopasswd \
;fi

WORKDIR /opt/atom/build

COPY electron-mksnapshot-9.0.2-linux-arm64.tar.gz .

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y --no-install-recommends install sudo vim curl xz-utils ca-certificates python2 libgdk-pixbuf2.0-0 libgtk-3-0 libx11-xcb1 libxss1 && \
    mkdir -p /usr/local/lib/nodejs && \
    curl https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz | tar -xJ -C /usr/local/lib/nodejs && \
    ln -s /usr/local/lib/nodejs/node-${NODE_VERSION}-${NODE_DISTRO}/bin/node /usr/bin/node && \
    ln -s /usr/local/lib/nodejs/node-${NODE_VERSION}-${NODE_DISTRO}/bin/npm /usr/bin/npm && \
    ln -s /usr/local/lib/nodejs/node-${NODE_VERSION}-${NODE_DISTRO}/bin/npx /usr/bin/npx && \ 
    apt-get -y --no-install-recommends install build-essential git libsecret-1-dev fakeroot rpm libx11-dev libxkbfile-dev && \
    npm config set python /usr/bin/python2 -g && \
    git clone https://github.com/atom/atom.git && \
    cd atom && \
    git checkout tags/${ATOM_VERSION} && \
    tar xfz ../electron-mksnapshot-9.0.2-linux-arm64.tar.gz -C script && \
    rm ../electron-mksnapshot-9.0.2-linux-arm64.tar.gz && \
    chown -R atom:atom /opt/atom/build && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/atom/build/atom

USER atom
