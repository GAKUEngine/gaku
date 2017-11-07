# First Run
  - Run `docker-compose up`. All ubuntu and gem packages will be installed and app with services will be up

# Add new migration
  - add new migration to gaku gem
  - run `docker-compose exec web bundle exec rake railties:install:migrations` to copy migrations in app db/migrations
  - run `docker-compose exec web bundle exec rake db:migrate` to install migrations

# Add new gem
  - add gem in gemspec files and then stop and run docker-compose

# Add sample data
 - run `docker-compose exec web bundle exec rake db:sample`

# NOTE!!!
  - do not run `docker-compose up --build` because will install initialize app, will download all gems  and will copy migrations again and will not start becase of duplicated tables
