require "ostruct"
require File.join(File.dirname(__FILE__), "talk")

class Session < OpenStruct
  
  def end_at?(time)
    self.end <= time
  end

  def talks
    @talks ||= talk_ids ? talk_ids.map {|id| Talk.get(id) } : []
  end

  def hold_on?(time)
    self.start <= time && self.end > time
  end

  def normal_session?
    !self.event_type
  end

  def empty?
    normal_session? && talks.empty?
  end

end
