
# Stage 1: Build React Application
FROM node:20 AS build

WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

# Build React application
RUN NODE_OPTIONS=--openssl-legacy-provider npm run build


# Stage 2: Deploy using Nginx
FROM nginx:alpine

# Copy production build files
COPY --from=build /app/build /usr/share/nginx/html

# Expose application port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
