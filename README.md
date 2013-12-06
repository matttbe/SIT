SIT
===

Before testing :
----------------

As we use RoR as framework for the solidare-it website implementation, you must Ruby 2.0 (ruby2.0 and ruby2.0-dev) and Rails 4.0.2 installed on your computer. To install Rails, run the 'gem install rails' command. For the development version, we use sqlite3 for the database, but note that if you want to have the website in production version, we planned to use PostgreSQL.

Test the website :
------------------

**TODO : ACCES AU GÎTE OU ARCHIVE **

Go to the '/path/to/SIT/website/Solidare-IT-g6/' folder. Then, if it's the first time you want to run the application, run the 'bundle install', 'rake db:create:all' and 'rake db:migrate' commands. Then you have to lauch the server with the 'rails server' command.

Note that in case of new ruby dependance(s), you have to run the 'bundle update' command and if you have to set up the database run the 'rake db:setup' command (always in the '/path/to/SIT/website/Solidare-IT-g6/' folder).

After that, just open a browser (not IE, a real one) and visit the 'http://localhost:3000/' URL. Then you can see the website as a non-registered user.
