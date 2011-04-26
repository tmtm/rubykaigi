require "ostruct"
require File.join(File.dirname(__FILE__), "event")

module RubyKaigi2011
  class Session < OpenStruct

    def events
      @events ||= event_ids ? event_ids.map {|id| Event.find(id) } : []
    end

    def hold_on?(time)
      self.start <= time && self.end > time
    end

    def empty?
      events.empty?
    end

    def to_hash
      hash = @table.dup

      hash.delete(:event_ids)
      hash[:events] = events.map(&:"to_hash")

      hash
    end

  end
end
