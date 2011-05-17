set :appdir, 'railsapp.staging'
set :branch, "master"
server 'staging.rubykaigi.org', :app, :web, :db, :primary => true
