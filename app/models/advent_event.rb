class AdventEvent
  cattr_reader :raw_events
  attr_accessor :id, :name, :dtstart, :dtend, :description, :location

  def initialize(attrs={})
    attrs.symbolize_keys!
    self.id, self.description, self.location = attrs[:id], attrs[:description], attrs[:location]
    self.dtstart = Time.parse attrs[:dtstart] if attrs[:dtstart].present?
    self.dtend = Time.parse attrs[:dtend] if attrs[:dtend].present?
    self.name = attrs["name_#{I18n.locale}".intern]
  end

  def to_hash
    instance_variables.inject({}) do |hash, ivn|
      hash[ivn[1..-1]] = instance_variable_get ivn
      hash
    end
  end

  class << self
    extend ActiveSupport::Memoizable
    delegate :to_json, :to => :all

    def load(year)
      @@raw_events ||= YAML.load File.open Rails.root.join('db', year.to_s, 'advent_events.yml'), 'r', &:read
    end

    def all
      raw_events.map{|id, e| new e.merge(:id => id) }.sort_by &:dtstart
    end

    def to_ical
      RiCal.Calendar do |cal|
        all.each do |e|
          cal.event do |event|
            event.summary     e.name
            event.description e.description
            event.dtstart     e.dtstart
            event.dtend       e.dtstart
            event.location    e.location
          end
        end
      end.to_s
    end

    memoize :all, :to_ical
  end

end
