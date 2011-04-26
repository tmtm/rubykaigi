require File.join(File.dirname(__FILE__), "yaml_loader")
require File.join(File.dirname(__FILE__), "session")

module RubyKaigi2011
  class RoomTimetable < OpenStruct
    extend YamlLoader

    base_dir File.join(File.dirname(__FILE__), "../../db/2011/room_timetables/")
    # base_dir Rails.root.join("db/2011/room_timetables")

    def sessions
      @sessions ||= timeslots.map {|t| Session.new(t) }
    end

    def periods
      sessions.map {|s| [ s.start, s.end ] }.flatten.uniq
    end

    def session_at(time)
      sessions.detect {|s| s.hold_on?(time) }
    end

    def to_hash
      hash = @table.dup

      hash.delete(:timeslots)
      hash[:sessions] = sessions.map(&:to_hash)

      hash
    end

  end
end
