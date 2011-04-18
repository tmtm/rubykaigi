#!/usr/bin/env ruby

require 'yaml'

Dir['talks/**/*.yaml'].each do |path|
  talk = YAML.load_file(path)
  p [path, talk['title']['en'], talk['name']['en']]
end
