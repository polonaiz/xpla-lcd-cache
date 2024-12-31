FROM mcr.microsoft.com/devcontainers/base:jammy

# make
RUN apt-get update && \
    apt-get install -y make vim bash-completion

# docker-ce-cli
# https://docs.docker.com/engine/install/ubuntu/
RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    (echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null) && \
    apt-get update && \
    apt-get install -y docker-ce-cli

