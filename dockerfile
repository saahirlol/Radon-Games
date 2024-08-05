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

# Copy local files to the Docker image
COPY . .

# Install dependencies
RUN pnpm install

# Build the project
RUN pnpm run build

# Expose the necessary port
EXPOSE 80

# Run the preview server on 0.0.0.0:80
CMD ["pnpm", "run", "preview", "--", "--host", "0.0.0.0", "--port", "80"]
