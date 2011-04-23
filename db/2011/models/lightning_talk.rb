require 'ostruct'
require File.join(File.dirname(__FILE__), "special_event")

class LightningTalk < OpenStruct 
  extend EventResource
  handle /LT$/
  
  extend YamlLoader
  base_dir File.join(File.dirname(__FILE__), "../events/")

  def self.get(id)
    super(id.to_s)
  end
  
  def talks
    @talks ||= talk_ids.map {|id| Talk.get(id) }
  end
end
