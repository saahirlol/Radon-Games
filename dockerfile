# Use the official Node.js 18 image as a base
FROM node:18

# Set the working directory
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN pnpm run build

# Install Caddy
RUN apt-get update && \
    apt-get install -y curl && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | apt-key add - && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt-get update && \
    apt-get install -y caddy

# Create the Caddyfile
RUN echo ":80 {\n reverse_proxy 127.0.0.1:4173\n}" > /etc/caddy/Caddyfile

# Expose the ports
EXPOSE 80

# Command to run both Caddy and the Node.js app
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
