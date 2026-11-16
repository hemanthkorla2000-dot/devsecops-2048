

FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN NODE_OPTIONS=--openssl-legacy-provider npm run build


# Stage 2: Nginx Deployment
FROM nginx:alpine

# Update Alpine packages to patched versions
RUN apk update && apk upgrade --no-cache

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
