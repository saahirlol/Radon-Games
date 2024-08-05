# Use an official Node.js runtime based on Alpine as a parent image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Install required packages for building native dependencies
RUN apk add --no-cache python3 make g++

# Copy the package.json and pnpm-lock.yaml files to the container
COPY package.json pnpm-lock.yaml ./

# Install pnpm globally
RUN npm install -g pnpm

# Install application dependencies
RUN pnpm install

# Copy the rest of the application code to the container
COPY . .

# Build the application
RUN pnpm run build

# Expose port 80 for the application
EXPOSE 80

# Start the application and force it to listen on port 80
CMD ["pnpm", "run", "preview", "--", "--port", "80"]
