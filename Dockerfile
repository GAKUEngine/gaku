FROM ubuntu:bionic
MAINTAINER Georgi Tapalilov & Rei Kagetsuki

EXPOSE 3000

RUN echo "nameserver 1.1.1.1" >> /etc/resolv.conf

RUN apt update
RUN apt upgrade -y
RUN apt install -y ruby ruby-dev build-essential imagemagick libmagickcore-dev git libpq-dev postgresql-client nodejs

RUN gem install rails -v 5.2.2 --no-ri --no-rdoc
RUN gem install bundler --no-ri --no-rdoc

ADD	.	/gaku
WORKDIR /gaku

ENV app /app
ENV gaku /gaku

RUN rails new $app --database=postgresql --skip-bundle

WORKDIR $app

RUN echo "gem 'gaku', path: '../gaku'" >> Gemfile
#RUN echo "gem 'therubyracer'" >> Gemfile
RUN echo "gem 'tzinfo-data'" >> Gemfile

RUN bundle install

RUN bundle exec rails g gaku:docker
