set :branch, "master"
set :appdir, 'railsapp'
server 'rubykaigi.org', :app, :web, :db, :primary => true
