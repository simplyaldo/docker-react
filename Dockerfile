# this is a multistep Dockerfile
# ----------------------
# set the phase as builder
FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build 

# when you put a new FROM its understood that the its the beginning of a new block

FROM nginx

# we are copying the build directory to /usr/share/nginx/html because its a NGINX thing
COPY --from=builder /app/build /usr/share/nginx/html

# we dont need a run command to start up nginx, the default command for the nginx images takes care of it