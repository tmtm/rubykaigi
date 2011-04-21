#!/usr/bin/env ruby

require 'yaml'
require 'enumerator'

require File.join(File.dirname(__FILE__), 'models/room_timetable')

Dir[File.join(File.dirname(__FILE__), "room_timetables/**/*.yaml")].map do |path|
  RoomTimetable.find(path)
end.group_by(&:date).each do |date, room_timetables|
  periods = room_timetables.inject([]) {|times, room_timetable| times + room_timetable.periods }.uniq.sort

  p room_timetables.map(&:room)

  periods.each_cons(2) do |s, e|

    row = []
    row << [s, e].map {|t| t.strftime("%H:%M") }.join('|')

    room_timetables.each do |room_timetable|
      
      schedule = room_timetable.schedule_at(s)

      row << '-' and next unless schedule 
      
      if schedule.break?
        row << 'Break' 
      else
        row << schedule.talks.map {|t| t.title["en"] }
      end
      row << '|' unless schedule.end_at?(e)
    end

    p row

  end

end
