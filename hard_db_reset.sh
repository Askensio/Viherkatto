echo "dropping database"
bundle exec rake db:drop
echo "creating a new database"
bundle exec rake db:create
echo "doing migrates"
bundle exec rake db:migrate
echo "preparing database for tests"
bundle exec rake db:test:prepare
echo "populating database"
bundle exec rake db:populate
