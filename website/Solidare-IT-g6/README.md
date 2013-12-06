Solidare-IT
===========

Solidare-IT Project for SINF2255 course at Université Catholique de Louvain.

Group 6

Students involved
------------------

* Matthieu Baerts
* Benoit Baufays
* Julien Colmonts
* Benjamin Frantzen
* Pierre-Yves Légéna
* Ludovic Vannoorenberghe
* Vincent Van Ouytsel
* Alex Vermeylen


Status
======

[![Build Status](https://travis-ci.org/matttbe/SIT.png?branch=master)](https://travis-ci.org/matttbe/SIT)
[![Dependency Status](https://gemnasium.com/matttbe/SIT.png)](https://gemnasium.com/matttbe/SIT)
[![Code Climate](https://codeclimate.com/github/matttbe/SIT.png)](https://codeclimate.com/github/matttbe/SIT)
[![Coverage Status](https://coveralls.io/repos/matttbe/SIT/badge.png)](https://coveralls.io/r/matttbe/SIT)
[![Stories in Ready](https://badge.waffle.io/matttbe/SIT.png?label=ready)](http://waffle.io/matttbe/SIT)


Installation
============

As we use Ruby on Rails as framework for the Solidare-IT website implementation, you must have Ruby (2.0) and Rails (4.0) installed on your computer.

Ruby and dependences: Instruction for Ubuntu
--------------------------------------------

Install dependences:

````
sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev libpg-dev
````

Now install Ruby 2.0

````
sudo apt-get install -y ruby2.0 ruby2.0-dev ruby2.0-doc
````

If these packages are not available, add this PPA:

````
sudo add-apt-repository ppa:brightbox/ruby-ng-experimental
sudo apt-get update
sudo apt-get install -y ruby2.0 ruby2.0-dev ruby2.0-doc
````

Then check that you use Ruby 2.0 and Gem 2.0 by default:

````
sudo update-alternatives --config ruby ## select ruby2.0
sudo update-alternatives --config gem ## select gem2.0
````

If you want to use PostgreSQL database (used for the production) instead of SQLite (used for the development), install these packages:

````
sudo apt-get install postgresql libpq-dev pgadmin3
````

Rails
-----

Now you can install Rails 4.0:

````
sudo gem install rdoc
sudo gem install rails
````

Now you can install other 'gems' with this command (from the directory of the website):

````
bundle install
````

Database
--------

Configure PostgreSQL if needed by editing `config/database.yml`.
If you want to use SQLite in development mode, nothing is needed.

Then prepare the database:

````
rake db:create:all
rake db:migrate
````

Environment file
----------------

You need to configure some key by creating `.env` file.
A skeleton is available in the `.env.example` file.

* Create `.env` file
* Modify `config/database.yml` (for PostgreSQL, check `config/database.yml.postgresql`)

Test the website:
-----------------

After that, just open a browser (not IE, a real one) and visit the [http://localhost:3000/] URL.
Then you can see the website as a non-registered user. You can sign-in with the user `root@localhost.local` and its password `password`.

Launch test cases:
------------------

We use `cucumber` to test our website. There are several tests and all of them are automatically tested on [Travis](https://travis-ci.org/matttbe/SIT).
If you want to launch the tests on your computer, simply launch this command from the root directory of the website: `cucumber`


License
=======

GPL3 (see `LICENCE` file)
