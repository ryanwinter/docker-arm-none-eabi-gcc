ARG VARIANT=buster
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

RUN apt-get update \
    && apt-get -y install --no-install-recommends bzip2 cmake ninja-build \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 | tar -xj
ENV PATH $PATH:/work/gcc-arm-none-eabi-10-2020-q4-major/bin
