require 'ostruct'
require File.join(File.dirname(__FILE__), "special_event")
require File.join(File.dirname(__FILE__), "yaml_loader")

class Celemony < OpenStruct
  extend EventResource
  handle "16MDN"
  handle "16MOP"
  handle "18MCL"

  extend YamlLoader
  base_dir File.join(File.dirname(__FILE__), "../events/")

  def self.get(id)
    super(id.to_s)
  end
  
end
