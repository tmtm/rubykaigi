namespace :cache do
  desc "remove all cache files"
  task :expire_all => :environment do
    sh "rm", "-rf", Rails.root.join("tmp", "rails-cache")
  end
end
