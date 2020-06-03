FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic

ENV LABEL_MAINTAINER="Martinus Suherman" \
    LABEL_VENDOR="martinussuherman" \
    LABEL_IMAGE_NAME="martinussuherman/code-server-net-sdk-bundle" \
    LABEL_URL="https://hub.docker.com/r/martinussuherman/code-server-net-sdk-bundle/" \
    LABEL_VCS_URL="https://github.com/martinussuherman/code-server-net-sdk-bundle" \
    LABEL_DESCRIPTION="Ubuntu Linux 18.04 LTS image that bundles .NET Core SDK and VS Code Server." \
    LABEL_LICENSE="GPL-3.0" \
    # container/gosu UID \
    EUID=1001 \
    # container/gosu GID \
    EGID=1001 \
    # container/gosu user name \
    EUSER=vscode \
    # container/gosu group name \
    EGROUP=vscode \
    # container user home dir \
    EHOME=/home/vscode \
    # additional directories to create + chown (space separated) \
    ECHOWNDIRS= \
    # additional files to create + chown (space separated) \
    ECHOWNFILES= \
    # container timezone \
    TZ=UTC 

# Install tzdata gosu and code-server
RUN apt-get update -y && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    apt-get install -y gosu && \
    apt-get clean && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    rm -rf ~/.cache/code-server/

COPY create_user_group_home.sh \
     chown_paths.sh \
     entrypoint_gosu.sh \
     entrypoint_crond.sh \
     entrypoint_exec.sh \
     /

RUN chmod +x \
    /create_user_group_home.sh \
    /chown_paths.sh \
    /entrypoint_gosu.sh \
    /entrypoint_crond.sh \
    /entrypoint_exec.sh

ENTRYPOINT ["/entrypoint_gosu.sh", "code-server"]
CMD ["--bind-addr 0.0.0.0:8080"]

#
ARG LABEL_VERSION="latest"
ARG LABEL_BUILD_DATE
ARG LABEL_VCS_REF

# Build-time metadata as defined at http://label-schema.org
LABEL maintainer=$LABEL_MAINTAINER \
      org.label-schema.build-date=$LABEL_BUILD_DATE \
      org.label-schema.description=$LABEL_DESCRIPTION \
      org.label-schema.name=$LABEL_IMAGE_NAME \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url=$LABEL_URL \
      org.label-schema.license=$LABEL_LICENSE \
      org.label-schema.vcs-ref=$LABEL_VCS_REF \
      org.label-schema.vcs-url=$LABEL_VCS_URL \
      org.label-schema.vendor=$LABEL_VENDOR \
      org.label-schema.version=$LABEL_VERSION
