#!/usr/bin/env ruby

require 'yaml'
require 'enumerator'

Dir[File.join(File.dirname(__FILE__), '../../lib/ruby_kaigi2011/*.rb')].each do |path|
  require path
end

timetable = RubyKaigi2011::Timetable.new
rooms = RubyKaigi2011::Room.all
room_ids = rooms.map(&:room_id)
locale = 'en'

timetable.days.each do |date|
  p rooms.map {|r| r.name[locale] }

  room_ids.map do |room_id|
    timetable.room_timetable_at(date, room_id)
  end

  timetable.periods_on(date).each_cons(2) do |s, e|

    row = []
    row << [s, e].map {|t| t.strftime("%H:%M") }.join('|')

    room_ids.each do |room_id|

      room_timetable = timetable.room_timetable_at(date, room_id)
      session = room_timetable.session_at(s)
      row << '-' and next if !session || session.empty?
 
      row << session.events.map {|t| t.title[locale] }
    end

    p row

  end

end
