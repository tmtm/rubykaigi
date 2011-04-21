require File.join(File.dirname(__FILE__), "yaml_loader")

class Talk < OpenStruct
  extend YamlLoader

  base_dir File.join(File.dirname(__FILE__), "../talks/")
  # base_dir Rails.root.join("db/2011/talks")

  def to_hash
    @table.dup
  end

end
