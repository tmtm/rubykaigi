#!/usr/bin/env ruby

require 'yaml'
require 'enumerator'

require './models/timetable'

Dir["timetables/**/*.yaml"].map do |path|
  Timetable.find(path)
end.sort_by(&:date).group_by(&:date).each do |date, timetables|
  periods = timetables.inject([]) {|times, timetable| times + timetable.periods }.uniq.sort

  p timetables.map(&:room)

  periods.each_cons(2) do |s, e|

    row = []
    row << [s, e].map {|t| t.strftime("%H:%M") }.join('|')

    timetables.each do |timetable|
      
      schedule = timetable.schedule_at(s)

      #timetable.schedules.each do |schedule|
        row << schedule.talks.map {|t| t.name["en"] }
        row << '|' unless schedule.end_at?(e)
      #end
    end

    p row

  end

end
