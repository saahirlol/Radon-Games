# Use an official Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

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

# Expose the port the app runs on
EXPOSE 4173

# Start the application
CMD ["pnpm", "run", "preview"]
