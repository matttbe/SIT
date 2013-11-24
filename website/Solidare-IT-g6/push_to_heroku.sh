#! /bin/bash

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
git push heroku master

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
