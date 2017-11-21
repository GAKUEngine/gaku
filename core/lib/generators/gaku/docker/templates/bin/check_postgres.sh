#!/bin/bash

while ! pg_isready -h postgres -p 5432 > /dev/null 2> /dev/null; do
  echo "Connecting to postgresql failed"
  sleep 1
done
rm /app/tmp/pids/server.pid
bundle check || bundle install

psql --host=postgres --port=5432 -U postgres -c "CREATE USER manabu WITH PASSWORD 'manabu';"
psql --host=postgres --port=5432 -U postgres -c "ALTER USER manabu WITH SUPERUSER;"
psql --host=postgres --port=5432 -U postgres -c "CREATE EXTENSION IF NOT EXISTS hstore;"

bundle exec rake db:create
bundle exec rake db:migrate
exec "$@"
