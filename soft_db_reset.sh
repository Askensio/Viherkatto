echo "reseting database"
bundle exec rake db:reset
echo "starting migrates"
bundle exec rake db:migrate
echo "preparing database for tests"
bundle exec rake db:test:prepare
echo "populating database"
bundle exec rake db:populate
