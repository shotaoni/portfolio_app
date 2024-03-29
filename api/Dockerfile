FROM ruby:2.7.1-alpine

ARG WORKDIR="app"
ARG HOST
ARG API_PORT
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG DB_HOST
ARG DB_NAME
ARG DB_USERNAME
ARG DB_PASSWORD
ARG S3_REGION
ARG S3_BUCKET
ARG RAILS_MASTER_KEY

ENV RUNTIME_PACKAGES      "linux-headers libxml2-dev make gcc libc-dev nodejs tzdata mysql-dev mysql-client yarn"
ENV DEV_PACKAGES          "build-base curl-dev"
ENV LANG                  C.UTF-8
ENV TZ                    Asia/Tokyo
ENV HOST                  $HOST
ENV PORT                  $API_PORT
ENV AWS_ACCESS_KEY_ID     $AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
ENV DB_HOST               $DB_HOST
ENV DB_NAME               $DB_NAME
ENV DB_USERNAME           $DB_USERNAME
ENV DB_PASSWORD           $DB_PASSWORD
ENV S3_REGION             $S3_REGION
ENV S3_BUCKET             $S3_BUCKET
ENV RAILS_MASTER_KEY      $RAILS_MASTER_KEY

WORKDIR ${WORKDIR}



COPY Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache ${RUNTIME_PACKAGES} && \
    apk add --update --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    apk add shared-mime-info  && \
    bundle install -j4 && \
    apk del build-dependencies

COPY . .

EXPOSE ${API_PORT}

CMD ["rails", "server", "-b", "0.0.0.0"]