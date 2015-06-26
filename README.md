[![Gem Version](https://badge.fury.io/rb/gaku.png)](http://badge.fury.io/rb/gaku)
[![Build Status](https://travis-ci.org/GAKUEngine/gaku.svg)](https://travis-ci.org/GAKUEngine/gaku)
[![Coverage Status](https://coveralls.io/repos/GAKUEngine/gaku/badge.png?branch=master)](https://coveralls.io/r/GAKUEngine/gaku?branch=master)
[![Code Climate](https://codeclimate.com/github/GAKUEngine/gaku.png)](https://codeclimate.com/github/GAKUEngine/gaku)
[![Gitter chat](https://badges.gitter.im/GAKUEngine/gaku.png)](https://gitter.im/GAKUEngine/gaku)
GAKU Engine [学エンジン]
========================
GAKU Engine, or just "GAKU" for short is the "Genshin Academic Karte Unification Engine". The gaku character 「学」 means "Learning", so saying GAKU Engine is roughly equivilent to saying "Learning Engine".

GAKU is a modular, extendable, Open Source school and student management system built on Rails.
GAKU is currently under heavy development.
-------------------------------------------------------------------------------
We do not currently recommend anyone use it in a production environment.

License
-------
This software is dual licensed under the GNU GPL version 3 and the AGPL version 3. Separate licenses are available upon consultation. Please contact info@genshin.org for details.

What does it do?
----------------
GAKU Engine is a full school and student management solution including student, staff, syllabus, course, class, exam management and more. It has a full grading system and offers templatable printable reports. Functionality can be enhanced with extensions and can be integrated with external services and clients using the API. 

GAKU Engine is also:
* Completely Open Source, Free as in Freedom, licensed under the GPL v3 and AGPL 3.
* It only uses Free Open Source components and does not rely on a licensed back end.
* There are no per-seat licenses.
* It's Rails based, so it's easily modifyable and extendable.
* It does not require a special client to use. Any standards compliant web browser will do.
* It is multi-locale.

Demo
----
http://demo.gakuengine.com/

user: admin,   pass: 123456

Requirements
------------
* ruby >= 2.0.0
* postgresql >= 9.2
* postgresql-contrib >= 9.2

Installation
------------

### Install postgresql

    $ sudo apt-get update
    $ sudo apt-get install postgresql postgresql-contrib libpq-dev


### Install GAKU

Create a new Rails application:

    $ gem install rails -v 4.2.0
    $ rails new my_app


Then add GAKU to your Gemfile:
```ruby
gem 'gaku', '~> 0.2.4'
```

Or use the master branch:
```ruby
gem 'gaku', github: 'GAKUEngine/gaku'
```


Install dependencies:

    $ bundle

Edit config/database.yml to use postgre. Example:

```yml
    
development:
  adapter: postgresql
  database: gaku_development
  username: postgres
  min_messages: warning
test:
  adapter: postgresql
  database: gaku_test
  username: postgres
  min_messages: warning
production:
  adapter: postgresql
  database: gaku_production
  username: postgres
  min_messages: warning

```


Create the database:

    $ rake db:create:all

Run the install generator to copy migrations, initializers, run seed data...

    $ rails g gaku:install

Sample Data
-----------
If you want to populate sample data:

    $ rake db:sample

Defaults:
user: admin / pass: 123456


Run
---

    $ rails s


Check http://localhost:3000



Testing
-------
Each component of GAKU Engine has its own set of tests. Core functionality is found in core, Front End functionality is forund in frontend, etc. Generally you'll want to run tests in core, so the example here is for core.

Change to core engine:

    $ cd core

Recreate test_app:

    $ bundle exec rake test_app

Run specs using Selenium:

    $ rspec


Development
-----------

### Status

Development continuing is contigent upon receiving proper funding. We'll be running a Kickstarter to try and raise funds but we are also open to other investments including VC.

If you would like to participate in development or if you are a school and would like to see GAKU Engine developed plese contact Genshin Souzou K.K. at info@genshin.org

Pull requests are very welcome! Please try to follow these simple rules if applicable:

Separate branch:

* Please create a feature branch for every separate change you make.
* Open a pull-request early for any new features to get feedback.
* Make sure your patches are well tested. All specs must pass.
* Follow Bozhidar Batsov's style guides: [ruby-style-guide](http://github.com/bbatsov/ruby-style-guide) and [rails-style-guide](https://github.com/bbatsov/rails-style-guide).
* Run [rubocop](http://github.com/bbatsov/rubocop) to ensure no style guide issues.

Master branch:

* Commit directly onto the master branch only for typos, improvements to the readme and documentation.

### Project Lead

[Rei Kagetsuki](http://github.com/Kagetsuki)

### Core Team

* [Vassil Kalkov](http://github.com/kalkov) ([@versicolor](http://twitter.com/versicolor), [blog](http://kalkov.github.io))
* [Georgi Tapalilov](http://github.com/tapalilov)

### Semi-Active Members
* [Yukiharu Nakaya](http://github.com/snowsunny)
* Seth Lewis

### Inactive/Previously Involved Core Members
* [Radoslav Georgiev](http://github.com/absolu7)
* [Marta Kostova](http://github.com/martakostova)

### Contributors

[https://github.com/GAKUEngine/gaku/contributors](http://github.com/GAKUEngine/gaku/contributors)
