# Use Alpine as the base image
FROM alpine:latest

# Install necessary packages and add repositories for Node.js
RUN apk update && \
    apk add --no-cache \
    curl \
    bash \
    build-base \
    ca-certificates \
    git \
    libgcc \
    libstdc++ \
    && update-ca-certificates

# Install Node.js
RUN apk add --no-cache nodejs npm

# Install pnpm using npm
RUN npm install -g pnpm

# Set the working directory
WORKDIR /app

# Clone the GitHub repository
RUN git clone https://github.com/Radon-Games/Radon-Games.git .

# Install dependencies
RUN pnpm install

# Build the project
RUN pnpm run build

# Expose the necessary port
EXPOSE 4173

# Run the preview server
CMD ["pnpm", "run", "preview"]
