[![Gem Version](https://badge.fury.io/rb/gaku.svg)](http://badge.fury.io/rb/gaku)
[![Build Status](https://travis-ci.org/GAKUEngine/gaku.svg)](https://travis-ci.org/GAKUEngine/gaku)
[![Code Climate](https://codeclimate.com/github/GAKUEngine/gaku.svg)](https://codeclimate.com/github/GAKUEngine/gaku)
[![Gitter chat](https://badges.gitter.im/GAKUEngine/gaku.svg)](https://gitter.im/GAKUEngine/gaku)
GAKU Engine [学エンジン]
========================
GAKU Engine, or just "GAKU" for short is the "GenSou Academic Karte Unification Engine". The gaku 
character 「学」 means "Learning", so saying GAKU Engine is roughly equivilent to saying 
"Learning Engine".

GAKU is a modular, extendable, Open Source school and student management system built on Rails.

GAKU is currently under heavy development
-----------------------------------------
We do not currently recommend anyone use it in a production environment.

License
-------
This software is dual licensed under the GNU GPL version 3 and the AGPL version 3.   
Separate licenses are available upon consultation. Please contact info@gakuengine.com for details.

What does it do?
----------------
GAKU Engine is a full school and student management solution including student, staff, syllabus, 
course, class, exam management and more. It has a full grading system and offers templatable 
printable reports. Functionality can be enhanced with extensions and can be integrated with 
external services and clients using the API. 

GAKU Engine is also:
* Completely Open Source, Free as in Freedom, licensed under the GPL v3 and AGPL 3.
* It only uses Free Open Source components and does not rely on commercial components.
* There are no per-seat licenses.
* It's Rails based, so it's easily modifyable and extendable.
* It is multi-locale.

Requirements
------------
Full installation:
* A newer version of Ruby and a user account that can install Gems
* A newer version of postgresql and postgresql-contrib

Docker instance:
* A newer version of Ruby and a user account that can install Gems
* Docker and docker-compose

New Installation
----------------
*work in progress*

### Install the 'gaku' gem and command
```shell
gem install gaku
```

### Create a GAKU installation
```shell
gaku install MySchoolName
```
*Replace MySchoolName with your school name or the name you want for your GAKU installation.*  
*Please avoid using spaces and special characters in your installation name.*

Manual Installation
-------------------
0. Create a Rails app using PostgreSQL as your database and configure your config/database.yml
1. Add the following to your Gemfile: ```gem 'gaku'``` and run ```bundle install```
2. Run the GAKU install generator with ```bundle exec rails g gaku:install```

Updating
--------
To update a GAKU Engine installation, cd into your installation directory and:
1. Update your bundle with ```bundle update```
2. Update by running the install generator again with ```bundle exec rails g gaku:install```

Developer Information
=====================
There are several ways to work on GAKU Engine itself. We recommend creating an installation 
and pointing the Gemfile entires to a locally cloned repository. In this case we do not use 
Docker, so you'll need to run servers locally. First off, let's clone the repository. If 
you are intent on submitting a patch it may be a good idea to fork the repository in advance 
and clone your fork, but you can always fork later and push to your fork before you submit a 
pull/merge request.  
  
To make things easy, we recommend cloning the repository in the same path that your installation 
is contained in, and the remainder of this guide will assume this layout:
```shell
git clone git@github.com:GAKUEngine/gaku.git
```
  
If you don't have an existing installation or want to create a separate development installation 
then we recommend cloning the repository first, then running the gaku command from within the 
cloned repository.
```shell
cd gaku
gem install bundler
bundle install
bundle exec bin/gaku new ../GakuSample
```

Then, cd to the directory of the installation you'll use for testing (GakuSample if you followed 
the above setup step) and edit the Gemfile, changing the following entires as shown:
```
gem 'gaku', path: '../gaku'
```

Testing
-------
Testing does not use a sample app like above, instead there is a self contained test app and 
specs are run directly against this.  
  
Each component of GAKU Engine has its own set of tests. Core functionality is found in core, 
Front End functionality is forund in frontend, etc. Generally you'll want to run tests in core, 
so the example here is for core.
  
Change to core engine:
```shell
cd core
```
  
Initialize the test app
```shell
bundle exec rake test_app
```
  
Run specs:
```
rspec
```

Working on Windows
==================
Windows isn't a very comfortable platoform to work on due to lack of a consolidated/standard 
shared environemnt and tools. To work on Windows we recommend the following:
1. An installation of MSYS2. This can be the installation that comes with the Ruby 
  installer/dev kit.
2. An installation of Docker or Docker toolbox.
3. An installation of PostgreSQL. Depending on how you install PostgreSQL the pg gem 
  installation may be difficult - know that we can't provide assistance for this.
4. Docker toolbox and Postgre added to your path in MSYS2. Basically add something like 
  this to your .bashrc or .zshrc or the rc file for your shell of choice: 
  ```PATH=$PATH:/c/Program\ Files/Docker\ Toolbox/:/c/PostgreSQL/pg11/bin/```  
  * This example uses Docker Toolbox and BigSQL Postgre for Windows. If you have a different 
    Docker and Postgre installation replace the above with the path to where you have 
    docker(.exe), docker-compose(.exe) installed and where you have pg_config(.exe) and 
    psql(.exe) installed.
5. Ruby - either installed and accessable from within MSYS2 from the Ruby for Windows Installer 
  or installed with ```pacman -S ruby``` within a standalone MSYS2 installation.
6. You will need the basics for building Rails native extensions. A rough installation command 
  would be something like: 
  ```pacman -S libxml2 libxml2-devel zlib zlib-devel libxslt libxslt-devel libffi libffi-devel``` 
  and set bundler to use native libraries: 
  ```bundle config build.nokogiri --use-system-libraries```
7. Clone this repository, and run bundler. If any gems fail to install you may need to 
  install additional tools or adjust your environment variables. Windows is very difficult 
  to create a standard installation procedure on, so this may be easier said than done.
8. Start Docker (EG: run the QuickStart terminal) if it's not started already, then Run 
  ```./bin/gaku container start```. If you get an error about named pipes you'll probably have 
  to run the container from the Docker terminal (which should be using your installation of MSYS2).
9. Once the container has started once, you should be able to start it as many times and use it as 
  you like. Specifically, it should be usable for development on Windows and for developing 
  and testing clients or tools that run on Windows or are Windows native.

!NOTE!
When running specs on Windows, specfy where your GAKU directory is by prefixing commands with 
GAKU_PATH="/path/to/gaku", replacing the path here with the actual path to the cloned GAKU 
directory. The gaku container command maintains an information file about the IP and port 
the docker container is running on in tmp/container_info, and apps should read this file 
to set up their connections accordingly.

Development
===========
Status
------
Development has been resumed, but not full time. We are currently actively seeking funding, 
and current development efforts are targeted at providing an MVP [Minimum Viable Product] 
to seek full funding with buiness partners looking to utilize GAKU Engine to provide their 
own services. If you would be looking to provide GAKU Engine as your own service or to sponsor 
GAKU Engine development please contact us at info@gakuengine.com.  
  
If you are an OSS developer looking to contribute to GAKU Engine please contact 
info@gakuengine.com for tasks and guiance. You will be fully credited for your work, and we 
will absolutely do our best to compensate you for your work.  
  
Pull requests are very welcome! Please try to follow these simple rules:
* Please create a feature branch for every separate change you make.
* Open a pull-request early for any new features to get feedback.
* Make sure your patches are well tested. All specs must pass.
* Run [rubocop](http://github.com/bbatsov/rubocop) to ensure no style guide issues.

Core Team
=========
* [Rei Kagetsuki](http://github.com/Kagetsuki)
* [Georgi Tapalilov](http://github.com/tapalilov)
* [Yukiharu Nakaya](http://github.com/snowsunny)

Contributors
============

[https://github.com/GAKUEngine/gaku/contributors](http://github.com/GAKUEngine/gaku/contributors)

Code of Coduct
--------------
We welcome anyone. We will not exclde people from this project based on their identity, 
preferences, political affiliation, opinions, or how they chose to express themselves on any 
media. If you writCCe good code we're happy to have you as a contributor.
