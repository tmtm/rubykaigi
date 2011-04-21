require "yaml"
require "ostruct"

class Base < OpenStruct

  class << self

    def base_dir(path = nil)
      if path
        @base_dir = path
      else  
        @base_dir
      end
    end

    def get(id)
      find(File.join(base_dir, id))
    end

    def find(path)
      new(load(path))
    end

    def all
      Dir[File.join(base_dir, "**/*.yaml")].map {|path| find(path) }
    end

    def load(path)
      path = path + ".yaml" if File.extname(path).empty?
      YAML.load_file(path)
    end
  end

end
