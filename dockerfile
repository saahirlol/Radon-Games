# Use the official Node.js image as a base image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /

# Install pnpm globally
RUN npm install -g pnpm

# Install dependencies
RUN pnpm install

# Build the application
RUN pnpm run build

# Expose the port the app runs on
EXPOSE 4173

# Start the application
CMD ["pnpm", "run", "preview"]
