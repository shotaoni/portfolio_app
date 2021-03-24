FROM node:15.8.0-alpine

ARG WORKDIR
ARG CONTAINER_PORT
ARG API_URL
ARG HOST

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL}

WORKDIR ${HOME}

COPY package*.json ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache make gcc g++ python && \
    yarn install && \
    rm -rf /var/cache/apk/*

COPY . .

ARG WORKDIR="app"
ARG API_KEY
ARG AUTH_DOMAIN
ARG PROJECT_ID
ARG DATABASE_URL
ARG STORAGE_BUCKET
ARG MESSAGE_SENDER_ID
ARG FRONT_PORT

ENV API_KEY               $API_KEY
ENV AUTH_DOMAIN           $AUTH_DOMAIN
ENV PROJECT_ID            $PROJECT_ID
ENV DATABASE_URL          $DATABASE_URL
ENV STORAGE_BUCKET        $STORAGE_BUCKET
ENV MESSAGE_SENDER_ID     $MESSAGE_SENDER_ID

EXPOSE ${FRONT_PORT}

CMD ["rails" "server" "-b" "${HOST}"]