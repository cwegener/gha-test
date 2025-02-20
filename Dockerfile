FROM docker.io/ubuntu:noble AS build

SHELL ["sh", "-exc"]

### Start build prep.
### This should be a separate build container for better reuse.

RUN <<EOT
apt-get update -qy
apt-get install -qyy \
    -o APT::Install-Recommends=false \
    -o APT::Install-Suggests=false \
    build-essential \
    ca-certificates \
    wget \
    gnupg
EOT

RUN <<EOT
# install mise ... we'll wrap this around all build jobs going forward to deal with Java, Go, Node etc.
install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor > /etc/apt/keyrings/mise-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" > /etc/apt/sources.list.d/mise.list
apt-get update -qy
apt-get install -qyy \
    -o APT::Install-Recommends=false \
    -o APT::Install-Suggests=false \
    mise
EOT

RUN mise install -y go@1.23

COPY . .

RUN mise exec go@1.23 -- go build main.go

# Don't allow changes to containerized project files

### End build prep -- this is where your app Dockerfile should start.

FROM docker.io/ubuntu:noble

RUN apt-get update

RUN apt-get clean autoclean

COPY --from=build main /app/bin/main

RUN useradd -m webapp
USER webapp

ENTRYPOINT ["/app/bin/main"]
