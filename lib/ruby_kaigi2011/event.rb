require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Event < OpenStruct
    extend YamlLoader

    base_dir File.join(File.dirname(__FILE__), "../../db/2011/events/")

    def sub_events
      @sub_events ||= Event.find_by_ids(sub_event_ids || [])
    end

    def localize(locale, *attr_names)
      attrs = self.send(attr_names.shift)
      value = attr_names.inject(attrs) do |context , attr_name|
        context[attr_name.to_s]
      end
      return value unless value.is_a?(Hash)

      locale_orders(locale).each do |l|
        return value[l] if value[l]
      end
    end

    def to_hash
      hash = @table.dup
      hash.delete(:sub_event_ids)
      hash[:sub_events] = sub_events.map(&:to_hash) unless sub_events.empty?
      hash
    end

    private
    def locale_orders(required_locale)
      ([ required_locale.to_s ] << 'en').uniq
    end
  end
end
