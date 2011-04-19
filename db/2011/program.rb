#!/usr/bin/env ruby

require 'yaml'

Dir["timetables/**/*.yaml"].each do |path|
  timetable = YAML.load_file(path)
  timetable["timeslots"].each do |timeslot|
    p [
      timetable["date"].strftime("%Y/%m/%d"),
      timetable["room"],
      %w(start end).map {|k| timeslot[k].strftime("%H:%M") },
      timeslot["talks"]
    ]
  end
end

