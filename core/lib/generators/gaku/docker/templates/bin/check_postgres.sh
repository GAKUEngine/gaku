#!/bin/bash

while ! pg_isready -h postgres -p 5432 > /dev/null 2> /dev/null; do
  echo "Connecting to postgresql failed"
  sleep 1
done
bundle check || bundle install  

bundle exec rake db:create
bundle exec rake db:migrate
exec "$@"
