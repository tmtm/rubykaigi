class AdventEvent
  cattr_reader :raw_events
  attr_accessor :id, :name, :dtstart, :dtend, :url, :location, :pub_date, :hosted_by

  def initialize(attrs={})
    attrs.symbolize_keys!
    self.id, self.url, self.location = attrs[:id], attrs[:url], attrs[:location]
    self.dtstart  = Time.zone.parse attrs[:dtstart] if attrs[:dtstart].present?
    self.dtend    = Time.zone.parse attrs[:dtend]   if attrs[:dtend].present?
    self.pub_date = Time.zone.parse attrs[:pub_date]   if attrs[:pub_date].present?
    self.name    = attrs["name_#{I18n.locale}".intern]
    self.hosted_by = attrs["hosted_by_#{I18n.locale}".intern]
  end

  def today?
    (dtstart.beginning_of_day..dtend.end_of_day).include? Time.now
  end

  def to_hash
    instance_variables.inject({}) do |hash, ivn|
      hash[ivn[1..-1]] = instance_variable_get ivn
      hash
    end
  end

  class << self
    def load(year)
      @@raw_events ||= YAML.load File.open Rails.root.join('db', year.to_s, 'advent_events.yml'), 'r', &:read
    end

    def all
      raw_events.map{|id, e| new e.merge(:id => id) }.sort_by &:dtstart
    end

    def by_month
      all.inject(ActiveSupport::OrderedHash.new) do |months, event|
        month = event.dtstart.beginning_of_month
        months[month] ||= []
        months[month] << event
        months
      end
    end

  end
end
