ARG VARIANT="buster"
FROM buildpack-deps:${VARIANT}-curl

RUN apt-get update \
    && apt-get -y install --no-install-recommends git sudo locales \ 
    && apt-get -y install --no-install-recommends libncurses5 git wget bzip2 cmake ninja-build \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"
# Don't install the default packages
ARG PACKAGES_ALREADY_INSTALLED="true"

# Install needed packages and setup non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "${PACKAGES_ALREADY_INSTALLED}" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# pull the gcc-arm-none-eabi tarball
WORKDIR /work
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj
ENV PATH $PATH:/work/gcc-arm-none-eabi-9-2019-q4-major/bin