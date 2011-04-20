require "ostruct"
require File.join(File.dirname(__FILE__), "talk")

class Schedule < OpenStruct
  
  def end_at?(time)
    self.end <= time
  end

  def talks
    @talks ||= talk_ids.map {|id| Talk.get(id) }
  end

  def hold_on?(time)
    start <= time && self.end > time
  end

end
