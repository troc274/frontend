# Dockerfile in my-frontend
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app source and build it
COPY . .
RUN npm run build