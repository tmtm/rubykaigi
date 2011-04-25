require "ostruct"
require File.join(File.dirname(__FILE__), "talk")

class Session < OpenStruct

  def talks
    events
  end

  # TODO remove me
  def events
    @events ||= event_ids ? event_ids.map {|id| Talk.get(id) } : []
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

    hash.delete(:event_ids)
    hash[:talks] = talks.map(&:"to_hash")
  
    hash
  end

end
