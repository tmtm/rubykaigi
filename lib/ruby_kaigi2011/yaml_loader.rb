require "yaml"
require "ostruct"

module RubyKaigi2011
  module YamlLoader
    def base_dir(path)
      @base_dir = path
    end

    def find(id)
      load(File.join(@base_dir, id.to_s+".yaml"))
    end

    def all
      Dir[File.join(@base_dir, "**/*.yaml")].map {|path| load(path) }
    end

    def load(path)
      attrs = YAML.load_file(path)
      attrs[:_id] = File.basename(path, ".yaml")
      new(attrs)
    end
  end
end
