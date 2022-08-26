ARG VARIANT=ubuntu
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# Install cmake repository
RUN wget -qO- https://apt.kitware.com/kitware-archive.sh | sh

RUN apt update \
    && apt -y install --no-install-recommends gzip ninja-build gpg wget cmake \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install GCC
WORKDIR /work
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-eabi.tar.xz | tar -xz
ENV PATH $PATH:/work/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-eabi/bin