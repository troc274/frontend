FROM jenkins/inbound-agent:latest

# Switch to root user to install dependencies
USER root

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest && \
    apt-get clean

# Revert to jenkins user
USER jenkins

# Expose default JNLP port
EXPOSE 50000
