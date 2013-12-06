SIT
===

Solidare-IT Project for SINF2255 course at Université Catholique de Louvain.
Group 6
Students involved:
Matthieu Baerts
Benoit Baufays
Julien Colmonts
Benjamin Frantzen
Pierre-Yves Légéna
Ludovic Vannoorenberghe
Vincent Van Ouytsel
Alex Vermeylen


Before testing :
----------------

As we use RoR as framework for the solidare-it website implementation, you must have Ruby 2.0 (ruby2.0 and ruby2.0-dev) and Rails 4.0.2 installed on your computer. To install Rails, run the 'gem install rails' command. For the development version, we use sqlite3 for the database, but note that if you want to have the website in production version, we planned to use PostgreSQL.

Test the website :
------------------

To access the code of our application, go to https://github.com/matttbe/SIT and clone the git repository.

Go to the '/path/to/SIT/website/Solidare-IT-g6/' folder. Then, if it's the first time you want to run the application, run the 'bundle install', 'rake db:create:all' and 'rake db:migrate' commands. Then you have to lauch the server with the 'rails server' command.

Then, to complete the set up, create a '.env' file at the root of this folder. Put theses lines in it :

'DROPBOX_APP_KEY=3anr6vr0s3wekck
DROPBOX_APP_SECRET=oyxf3qg6fvfcdnb
DROPBOX_ACCESS_TOKEN=05whntv1vfb7ktx2
DROPBOX_ACCESS_TOKEN_SECRET=6vd9xadsiahxzr4
DROPBOX_USER_ID=242424734
DROPBOX_ACCESS_TYPE=app_folder
SECRET_TOKEN=13202ea3ffa5e4bda332ba75bc4f7ef478d01aa42ec1c233dfea5b34b66663d180f022200cdc6745d8ee0c3df26fb862a7fb9c6181e30d5317bc57e4882967b4
SECRET_DEVISE=8fc4cea848e1dc56a168a079b2a45c471d913f54ac21e2034b282b7a11341d3f99d629ce961fd9c82c1551bf050cda730e16aff934590770fe9caeaee184835a
SECRET_KEY_BASE=52fd557800f18e460557f2714e88f27b809a5da40ab21b99bf5811352a0e6f762d812250171aba232809e83801bcc07883a4480f3c999a51d5e30f304438d1c7
SIT_DOMAIN=localhost
SIT_PORT=3000
SIT_MAIL_ADDRESS=smtp.gmail.com
SIT_MAIL_PORT=587
SIT_MAIL_USER=solidare.it.6@gmail.com
SIT_MAIL_PASSWORD=iloveponcin
SIT_MAIL_AUTH=plain
SIT_MAIL_TLS=true '

Note that in case of new ruby dependance(s), you have to run the 'bundle update' command and if you have to set up the database run the 'rake db:setup' command (always in the '/path/to/SIT/website/Solidare-IT-g6/' folder).

After that, just open a browser (not IE, a real one) and visit the 'http://localhost:3000/' URL. Then you can see the website as a non-registered user.
