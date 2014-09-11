#!/bin/bash

#set -e

git add -A
git commit -m "deploying"
git push

cd ~/dev/veritas
git pull
echo "rake assets:precompile"
bundle exec rake assets:precompile RAILS_ENV=production
echo "copying files..."
rsync -rvuz --delete ~/dev/veritas/ bholt@www.hfbctheoaks.com:web/theoaks --exclude='.git/' --exclude='log/' --exclude='tmp/cache'
echo "removing local precompiled assets"
rm -r ~/dev/veritas/public/assets/*
echo "bundle install"
ssh bholt@www.hfbctheoaks.com 'cd ~/web/theoaks && bundle install'
echo "rake db:migrate"
ssh bholt@www.hfbctheoaks.com 'cd ~/web/theoaks && bundle exec rake db:migrate RAILS_ENV="production"'
echo "rake tmp:clear"
ssh bholt@www.hfbctheoaks.com 'cd ~/web/theoaks && bundle exec rake tmp:clear'
echo "rake log:clear"
ssh bholt@www.hfbctheoaks.com 'cd ~/web/theoaks && bundle exec rake log:clear'
echo "touch tmp/restart.txt"
ssh bholt@www.hfbctheoaks.com 'touch ~/web/theoaks/tmp/restart.txt'
echo "Deploy Successful!"
