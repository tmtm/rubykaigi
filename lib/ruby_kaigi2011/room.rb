require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Room < OpenStruct
    extend YamlLoader

    base_dir File.join(File.dirname(__FILE__), "../../db/2011/rooms/")

    def self.all
      super.sort_by(&:order)
    end
  end
end
