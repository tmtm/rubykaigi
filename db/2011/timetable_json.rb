#!/usr/bin/env ruby

require 'rubygems'
require 'json'

Dir[File.join(File.dirname(__FILE__), 'models/*.rb')].each do |path|
  require path
end

class Time
  def to_json(*a)
    strftime("%Y-%m-%dT%H:%M:%S+09:00").to_json(*a)
  end
end

class TimetableJSON

  def render
    Timetable.new.to_hash.to_json
  end
  
  def call(env)
    header = {"Content-Type" => "application/json;charset=utf-8"}
    body = [Timetable.new.to_hash.to_json]
    [200, header, render]
  end

end

if $0 == __FILE__
  $KCODE = 'u'
  puts TimetableJSON.new.render
end

