require File.join(File.dirname(__FILE__), "yaml_loader")
require File.join(File.dirname(__FILE__), "event_resource")

class Talk < OpenStruct
  extend YamlLoader

  base_dir File.join(File.dirname(__FILE__), "../talks/")
  # base_dir Rails.root.join("db/2011/talks")

  extend EventResource
  handle /^1[6-8][MS]\d{2}/

  def to_hash
    @table.dup
  end

end
