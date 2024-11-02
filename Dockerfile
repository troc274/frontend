# Use a Node.js base image for building the application
FROM node:18 AS builder

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the application
RUN npm run build

# Stage 2: Use a lightweight web server to serve the built files
FROM nginx:alpine

# Copy the built files from the previous stage to the Nginx web root
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 8081
EXPOSE 8081

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
