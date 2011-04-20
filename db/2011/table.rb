#!/usr/bin/env ruby

require 'yaml'
require 'enumerator'

require File.join(File.dirname(__FILE__), 'models/timetable')

Dir[File.join(File.dirname(__FILE__), "timetables/**/*.yaml")].map do |path|
  Timetable.find(path)
end.group_by(&:date).each do |date, timetables|
  periods = timetables.inject([]) {|times, timetable| times + timetable.periods }.uniq.sort

  p timetables.map(&:room)

  periods.each_cons(2) do |s, e|

    row = []
    row << [s, e].map {|t| t.strftime("%H:%M") }.join('|')

    timetables.each do |timetable|
      
      schedule = timetable.schedule_at(s)

      row << '-' and next unless schedule 
      
      if schedule.break?
        row << 'Break' 
      else
        row << schedule.talks.map {|t| t.name["en"] }
      end
      row << '|' unless schedule.end_at?(e)
    end

    p row

  end

end
