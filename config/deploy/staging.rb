set :branch, "master"
set :appdir, 'railsapp.staging'
server 'staging.rubykaigi.org', :app, :web, :db, :primary => true
