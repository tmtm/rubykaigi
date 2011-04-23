require File.join(File.dirname(__FILE__), "event_resource")

# TODO make flexible design
class SpecialEvent
  extend EventResource

  handle :break
  handle :open
  handle :lunch
  handle :dinner
  handle :party
  handle :transit_time
  
  def self.get(id)
    new(id)
  end

  attr_reader :id

  def initialize(id)
    @id = id
  end

  def name
    id
  end

end
