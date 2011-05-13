require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Sponsor < OpenStruct
    extend YamlLoader
    include Localizer
    def self.yaml_path
      Rails.root.join("db/2011/sponsors", name.gsub(/(RubyKaigi2011::|Sponsor)/, '').downcase)
    end
  end
end
