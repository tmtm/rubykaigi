#!/usr/bin/env ruby

require 'yaml'
require 'enumerator'

require File.join(File.dirname(__FILE__), 'models/timetable')
Dir[File.join(File.dirname(__FILE__), 'models/*.rb')].each do |path|
  require path
end

timetable = Timetable.new

timetable.days.each do |date|
  room_timetables = timetable.room_timetables_on(date)

  p room_timetables.map(&:room)

  timetable.periods_on(date).each_cons(2) do |s, e|

    row = []
    row << [s, e].map {|t| t.strftime("%H:%M") }.join('|')

    room_timetables.each do |room_timetable|
      session = room_timetable.session_at(s)
      row << '-' and next if !session || session.empty?
    
      row << session.talks.map {|t| t.title["en"] } + session.special_events.map {|e| e.name }
    end

    p row

  end

end
