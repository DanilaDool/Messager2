set -p errexit

bundle install

apt_get install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate