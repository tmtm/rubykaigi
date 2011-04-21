require File.join(File.dirname(__FILE__), "room_timetable")

class Timetable
  def room_timetables
    @room_timetable ||= RoomTimetable.all
  end

  def days
    room_timetables.map {|r| r.date }.uniq
  end

  def room_timetables_on(date)
    room_timetables.select {|r| r.date == date }
  end

  def periods_on(date)
    room_timetables_on(date).map(&:periods).flatten.uniq.sort
  end

  def to_hash
    hash = {}

    days.each do |date|
      hash[date.strftime("%Y-%m-%d")] = room_timetables_on(date).map(&:"to_hash")
    end

    {:timetable => hash}
  end

end
