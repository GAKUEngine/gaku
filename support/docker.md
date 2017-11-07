# 1. First Run
  - Run 'docker-compose up'. All ubuntu and gem packages will be installed and app with services will be up

# 2. Migrations
  - add new migration to gaku gem
  - run 'docker-compose run web bundle exec rake railties:install:migrations' to copy migrations in app db/migrations
  - run 'docker-compose run web bundle exec rake db:migrate' to install migrations
