FROM alpine:3.18

ENV UNREAL_VERSION="6.1.2.3"

RUN apk add --no-cache \
    gnupg \
    build-base \ 
    openssl-dev \ 
    openssl
#    wget \
#    zlib-dev \
#    curl-dev \
#    pcre-dev

# Create unrealircd user
RUN adduser -D unrealircd
USER unrealircd
WORKDIR /home/unrealircd

# Import UnrealIRCd public key
RUN wget -O- https://raw.githubusercontent.com/unrealircd/unrealircd/unreal60_dev/doc/KEYS | gpg --import
RUN wget https://www.unrealircd.org/downloads/unrealircd-${UNREAL_VERSION}.tar.gz && \
    wget https://www.unrealircd.org/downloads/unrealircd-${UNREAL_VERSION}.tar.gz.asc && \
    gpg --verify unrealircd-${UNREAL_VERSION}.tar.gz.asc unrealircd-${UNREAL_VERSION}.tar.gz

# Extract and compile UnrealIRCd
RUN tar xzf unrealircd-${UNREAL_VERSION}.tar.gz && \
    cd unrealircd-${UNREAL_VERSION} && \
    ./Config && \
    make && \
    make install

# Cleanup
USER root
RUN ls /home/unrealircd
RUN apk del gnupg build-base && \
    rm -rf /home/unrealircd/unrealircd-${UNREAL_VERSION}.tar.gz /home/unrealircd/unrealircd-${UNREAL_VERSION}.tar.gz.asc


# Set working directory to UnrealIRCd installation
WORKDIR /home/unrealircd/unrealircd

# Expose necessary ports
EXPOSE 6667 6697

# Command to run UnrealIRCd as the non-root user
USER unrealircd
ENTRYPOINT [ "./unrealircd", "start" ]