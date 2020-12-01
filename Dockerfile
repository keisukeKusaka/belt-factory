FROM ruby:2.6.6

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  nodejs

RUN mkdir /belt-factory

ENV APP_ROOT /belt-factory
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT
