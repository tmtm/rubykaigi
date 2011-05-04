#!/usr/bin/env ruby

require 'enumerator'

require 'rubygems'
require 'haml'

Dir[File.join(File.dirname(__FILE__), '../../lib/ruby_kaigi2011/*.rb')].each do |path|
  require path
end

class TimetableHTML

  def render
    template = File.join(File.dirname(__FILE__), 'views/timetable.html.haml')
    Haml::Engine.new(File.read(template)).render(RubyKaigi2011::Timetable.new)
  end

  def call(env)
    [200, {"Content-Type" => "text/html; charset=utf-8"}, render]
  end

end

if $0 == __FILE__
  puts TimetableHTML.new.render
end
