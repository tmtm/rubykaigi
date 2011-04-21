require "ostruct"
require File.join(File.dirname(__FILE__), "talk")

class Session < OpenStruct
  
  def end_at?(time)
    self.end <= time
  end

  def talks
    @talks ||= talk_ids.map {|id| Talk.get(id) }
  end

  def hold_on?(time)
    self.start <= time && self.end > time
  end

  def break?
    !!self.break
  end
end
