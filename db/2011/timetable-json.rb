#!/usr/bin/env ruby

require 'rubygems'
require 'json'

require File.join(File.dirname(__FILE__), 'models/timetable')

class Time
  def to_json(*a)
    strftime("%Y-%m-%dT%H:%M:%S+09:00").to_json(*a)
  end
end

if $0 == __FILE__
   p Timetable.new.to_hash.to_json
end

