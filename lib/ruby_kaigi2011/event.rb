require File.join(File.dirname(__FILE__), "yaml_loader")

module RubyKaigi2011
  class Event < OpenStruct
    extend YamlLoader

    base_dir File.join(File.dirname(__FILE__), "../../db/2011/events/")

    def sub_events
      @sub_events ||= Event.find_by_ids(sub_event_ids || [])
    end

    def title_on_locale
      I18n.locale.to_s == 'ja' ? (title['ja'] || title['en']) : (title['en'] || title['ja'])
    end

    def presenter_on_locale
      if name
        I18n.locale.to_s == 'ja' ? (name['ja'] || name['en']) : (name['en'] || name['ja'])
      else
        ""
      end
    end

    def abstract_on_locale
      if abstract
        I18n.locale.to_s == 'ja' ? (abstract['ja'] || abstract['en']) : (abstract['en'] || abstract['ja'])
      else
        ""
      end
    end

    def to_hash
      hash = @table.dup
      hash.delete(:sub_event_ids)
      hash[:sub_events] = sub_events.map(&:to_hash) unless sub_events.empty?
      hash
    end
  end
end
