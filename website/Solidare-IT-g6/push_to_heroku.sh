#! /bin/bash

# Prepare
mv .git_heroku .git
mv Gemfile.lock Gemfile.lock.tmp
cp ../../Gemfile.lock .

# Push
echo "== Git: Add files =="
git add -v .
echo "== Git: commit =="
git commit -am "`date -R`"
echo "== Git: Push =="
git push heroku master

# stop
echo "== Press Enter to end =="
read
mv .git .git_heroku
mv Gemfile.lock.tmp Gemfile.lock

echo "Done"
