namespace :headline do
  desc "Fetch headlines from rubykaigi.tdiary.org"
  task :fetch => :environment do
    HeadlineEntry.crawl('http://rubykaigi.tdiary.net/index.rdf', 'rubykaigi2011').each do |e|
      puts "#{e.time.to_date.to_s(:db)} #{e.title} (#{e.language})"
    end
  end
end
