set :branch, "master"
set :appdir, 'railsapp'
server 'rubykaigi.org', :app, :web, :db, :primary => true

after("deploy:symlink") do
  run "cd #{current_path} && bundle exec whenever --update-crontab #{application}"
end

