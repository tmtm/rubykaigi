require "ostruct"
require File.join(File.dirname(__FILE__), "talk")
require File.join(File.dirname(__FILE__), "event_resource")

class Session < OpenStruct

  def talks
    events.select {|e| e.is_a?(Talk) }
  end

  def events
    @events ||= event_ids ? event_ids.map {|id| EventResource.get(id) } : []
  end

  def special_events
    events.reject {|e| e.is_a?(Talk) }
  end

  def hold_on?(time)
    self.start <= time && self.end > time
  end

  def empty?
    events.empty?
  end

  def normal_session?
    !talks.empty?
  end

  def to_hash
    hash = @table.dup

    hash.delete(:talk_ids)
    hash[:talks] = talks.map(&:"to_hash")
  
    hash
  end

end
