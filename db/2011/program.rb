#!/usr/bin/env ruby

require 'yaml'

require File.join(File.dirname(__FILE__), "models/timetable")

timetable = Timetable.new

timetable.room_timetables.each do |room_timetable|

  room_timetable.sessions.each do |session|
    p [
      room_timetable.date.strftime("%Y/%m/%d"),
      room_timetable.room,
      %w(start end).map {|k| session.send(k).strftime("%H:%M") },
      session.talk_ids
    ]
  end

end
