FROM ubuntu:16.04
MAINTAINER Georgi Tapalilov

EXPOSE 3000

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y cmake libpng-dev libboost-program-options-dev libboost-regex-dev libboost-system-dev libboost-filesystem-dev
RUN apt-get install -y build-essential
RUN apt-get install -y ruby2.3-dev
RUN apt-get install -y libgmp-dev
RUN apt-get install -y imagemagick
RUN apt-get install -y libmagickcore-dev libmagickwand-dev

RUN apt-get install -y git
RUN apt-get install -y libpq-dev postgresql-client

# ENV BUNDLE_PATH=/gems \
#     BUNDLE_BIN=/gems/bin \
#     GEM_HOME=/gems
#
# ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN gem install rails -v 5.0.2 --no-ri --no-rdoc
RUN gem install bundler --no-ri --no-rdoc

ADD	.	/gaku
WORKDIR /gaku

ENV app /app
ENV gaku /gaku

RUN rails new $app --database=postgresql --skip-bundle

WORKDIR $app

RUN echo "gem 'gaku', path: '../gaku'" >> Gemfile
RUN echo "gem 'therubyracer'" >> Gemfile
RUN echo "gem 'tzinfo-data'" >> Gemfile

RUN bundle install

# WORKDIR $app

RUN bundle exec rails g gaku:docker
# # prepare staging enviroment
# RUN echo "staging:\n  url: postgres://postgres:@postgres:5432/app_staging" >> config/database.yml
# RUN cp config/environments/development.rb config/environments/staging.rb
#
# # generate secret
# RUN SECRET="$(bundle exec rake secret)"; echo "staging:\n  secret_key_base: ${SECRET}" >> config/secrets.yml
#
# # wait for postgres script
# COPY support/docker/check_postgres.sh /usr/bin/check_postgres
# RUN chmod +x /usr/bin/check_postgres
#
# # add route
# RUN sed -i "2imount Gaku::Core::Engine, at: '/'" config/routes.rb
#
# # copy migrations
# RUN bundle exec rake gaku:install:migrations
#
# # assets
#
# RUN bundle exec rake assets:precompile
