require File.join(File.dirname(__FILE__), "timetable_json")
map '/timetable.json' do 
  run TimetableJSON.new
end

require File.join(File.dirname(__FILE__), "timetable_html")
%w(/timetable.html /timetable).each do |path|
  map path do
    run TimetableHTML.new
  end
end

map '/favicon.ico' do
  run proc { [200, {"Content-Type" => "text/plain"}, ""] }
end
