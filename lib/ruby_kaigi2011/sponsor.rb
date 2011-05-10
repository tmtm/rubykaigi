require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Sponsor < OpenStruct
    extend YamlLoader
    def self.yaml_path
      File.join(File.dirname(__FILE__), "../../db/2011/sponsors/", name.gsub(/(RubyKaigi2011::|Sponsor)/, '').downcase)
    end
  end
end
