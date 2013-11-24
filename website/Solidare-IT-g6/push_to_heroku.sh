#! /bin/bash

## New user?
# => Create an Heroku Account
# => Get rights for Sit-g6
# => Install Heroku Toolbelt: https://toolbelt.heroku.com/
#  cd website/Solidare-IT-g6
#  heroku login
#  git init
#  git remote add heroku git@heroku.com:sit-g6.git
#  mv .git .git_heroku
# => launch this script

# Prepare
mv .git_heroku .git || exit
mv Gemfile.lock Gemfile.lock.tmp || exit
cp ../../Gemfile.lock . || exit

# Push
echo "== Git: Add files =="
git add -v .
echo "== Git: commit =="
git commit -am "`date -R`"
echo "== Git: Push =="
git push --force heroku master

# DB
echo "== Migrate DB =="
heroku run rake db:migrate

# Open
echo "== Open website =="
heroku open

# stop
echo "== Press Enter to end =="
read
mv .git .git_heroku
mv Gemfile.lock.tmp Gemfile.lock

echo "Done"
