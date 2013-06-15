#!/bin/bash

cd ~/dev/veritas_web
git pull
mv ./config/database.yml ./config/database_orig.yml
cp ./config/database_deploy.yml ./config/database.yml
echo "rake assets:precompile"
bundle exec rake assets:precompile
mv ./config/database_orig.yml ./config/database.yml
echo "copying files..."
rsync -rvuz ~/dev/veritas_web/ bholt@geekytidbits.com:web/veritas --exclude='.git/' --exclude='log/'
echo "removing local precompiled assets"
rm -r ~/dev/veritas_web/public/assets/*
echo "bundle install"
ssh bholt@geekytidbits.com 'cd ~/web/veritas && bundle install'
echo "rake db:migrate"
ssh bholt@geekytidbits.com 'cd ~/web/veritas && bundle exec rake db:migrate RAILS_ENV="production"'
echo "rake tmp:clear"
ssh bholt@geekytidbits.com 'cd ~/web/veritas && bundle exec rake tmp:clear'
echo "touch tmp/restart.txt"
ssh bholt@geekytidbits.com 'touch ~/web/veritas/tmp/restart.txt'
echo "Deploy Successful!"
