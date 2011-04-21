require File.join(File.dirname(__FILE__), "base")
require File.join(File.dirname(__FILE__), "schedule")

class RoomTimetable < Base

  base_dir File.join(File.dirname(__FILE__), "../room_timetables/")
  # base_dir Rails.root.join("db/2011/talks")

  def schedules
    @schedules ||= timeslots.map {|t| Schedule.new(t) }
  end

  def periods
    schedules.map {|s| [ s.start, s.end ] }.flatten.uniq
  end

  def schedule_at(time)
    schedules.detect {|s| s.hold_on?(time) }
  end
end
