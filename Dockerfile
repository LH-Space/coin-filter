FROM node:21.4.0-alpine

ENV APP_ROOT /src

RUN mkdir ${APP_ROOT}
WORKDIR ${APP_ROOT}
ADD . ${APP_ROOT}

RUN npm install

COPY . .

RUN npm run build

ENV HOST 0.0.0.0