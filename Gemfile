# -*- coding: utf-8 -*-
source :rubygems
source 'http://gems.github.com'

gem 'rails', '3.0.6', :require => nil
gem 'mysql'
gem 'configatron'
gem "ambethia-smtp-tls", :require => "smtp-tls"
gem "fastercsv"
gem "hoptoad_notifier", '2.4.5'
gem 'i18n_generators'
gem 'haml'
gem 'fastercsv'
gem 'whenever', '0.4.2', :require => false
gem 'delayed_job'
gem 'rack-google-analytics', '0.6.1'
gem 'will_paginate'
gem 'redis-objects', :require => 'redis/objects'
gem 'SystemTimer'
gem 'twitter', '0.9.8'

gem 'rails_warden'
gem 'warden_oauth'
gem 'warden-openid'

gem 'god'

group :development do
  gem 'capistrano', :require => nil
  gem 'capistrano-ext', :require => nil
  gem 'capistrano-notification', '0.0.2', :require => nil
  gem 'gettext', '<2' # required by i18n_generators
  gem 'thin', :require => nil
end

group :test, :cucumber do
  gem 'rspec', '2.5.0'
  gem 'rspec-rails', '2.5.0', :group => :development
  gem 'rr'
  gem 'machinist', :require => 'machinist/active_record'
  gem 'faker'
  gem 'email_spec', '0.6.3'
  gem 'autotest-rails'
#  gem 'autotest-growl'
  gem 'daemons'
  gem 'spork'
  gem 'cucumber-rails', '~>0.3.2'
  gem 'webrat'
  gem 'moro-miso'
  gem 'database_cleaner'
  gem 'nokogiri'
  gem 'steak', :require => nil
  gem 'capybara'
end
