require File.join(File.dirname(__FILE__), "yaml_loader")


class Room < OpenStruct
  extend YamlLoader

  base_dir File.join(File.dirname(__FILE__), "../rooms/")

  def self.all
    super.sort_by(&:order)
  end

end
