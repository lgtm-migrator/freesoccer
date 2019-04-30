FROM node

RUN apt-get update && apt-get install -y build-essential && apt-get install -y python
RUN mkdir -p /api
RUN chown freesoccer /api
USER freesoccer
WORKDIR /api

COPY package.json /api
RUN yarn install --production
RUN yarn global add pm2

COPY . /api
RUN yarn build

CMD [ "yarn", "start-dev" ]

FROM node:alpine

RUN mkdir -p /app
RUN chown freesoccer /app
WORKDIR /app

COPY website /app
RUN yarn install --production
RUN yarn build

FROM nginx:1.13.9-alpine

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]