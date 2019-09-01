FROM node

RUN yarn global add pm2

RUN mkdir -p /api
WORKDIR /api

COPY . /api
RUN yarn install --production
RUN yarn build

EXPOSE 80

CMD ["pm2", "start", "dist/index.js", "--no-daemon"]