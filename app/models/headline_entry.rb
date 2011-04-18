class HeadlineEntry < ActiveRecord::Base
  validates_uniqueness_of :link

  LANGS = Hash.new('en').merge('ja' => 'ja')

  scope :recent, proc {|lang, limit| {:conditions => {:language => LANGS[lang.to_s]}, :order => 'time DESC', :limit => limit} }

  def self.crawl(feed_uri, category)
    require 'rss'
    require 'open-uri'

    RSS::Parser.parse(open(feed_uri)).items.select {|i|
      i.dc_subjects.map(&:content).include?(category)
    }.map {|i|
      HeadlineEntry.find_or_initialize_by_link(i.link).tap {|e|
        e.update_attributes!(
          :title    => i.title,
          :time     => i.date.to_s,
          :content  => i.content_encoded,
          :language => i.dc_subjects.map(&:content).include?('english') ? 'en' : 'ja'
        )
      }
    }
  end
end
