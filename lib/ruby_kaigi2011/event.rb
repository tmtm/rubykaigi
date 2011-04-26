require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Event < OpenStruct
    extend YamlLoader

    base_dir File.join(File.dirname(__FILE__), "../../db/2011/events/")

    def talks
      @talks ||= Event.find_by_ids(talk_ids || [])
    end

    def to_hash
      hash = @table.dup
      hash.delete(:talk_ids)
      hash[:talks] = talks.map(&:to_hash) unless talks.empty?
      hash
    end

  end
end
