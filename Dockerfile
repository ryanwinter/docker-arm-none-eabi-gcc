ARG VARIANT=ubuntu
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# Install cmake repository
RUN wget -qO- https://apt.kitware.com/kitware-archive.sh | sh

RUN apt update \
    && apt -y install --no-install-recommends ninja-build wget cmake xz-utils \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install GCC
WORKDIR /work
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | tar -xj
ENV PATH $PATH:/work/gcc-arm-none-eabi-10.3-2021.10/bin