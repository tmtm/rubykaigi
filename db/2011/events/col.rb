

Dir["./*.yaml"].each do |path|

  data = File.read(path)
  data.gsub!(/affilization/, 'affiliation')

  File.open(path, "w") do |f|
    p data =~ /affilization/
    f << data
  end

  p path

end
