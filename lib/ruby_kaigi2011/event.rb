require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Event < OpenStruct
    extend YamlLoader

    base_dir File.join(File.dirname(__FILE__), "../../db/2011/events/")

    def talks
      @talks ||= talk_ids ? talk_ids.map {|id| Event.find(id) } : []
    end

    def to_hash
      hash = @table.dup

      if talk_ids
        hash.delete(:talk_ids)
        hash[:talks] = talks.map(&:to_hash)
      end

      hash
    end

  end
end
