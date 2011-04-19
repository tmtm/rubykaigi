require "yaml"
require "ostruct"

class Base < OpenStruct

  class << self

    def load_path(path = nil)
      if path
        @load_path = path
      else  
        @load_path
      end
    end

    def get(id)
      find(File.join(load_path, id))
    end

    def find(path)
      new(load(path))
    end

    def load(path)
      path = path + ".yaml" if File.extname(path).empty?
      YAML.load_file(path)
    end
  end

end
