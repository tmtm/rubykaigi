#!/usr/bin/env ruby

require 'yaml'

Dir['events/**/*.yaml'].each do |path|
  talk = YAML.load_file(path)
  p [path, (talk['title'] || {})['en'], (talk['name'] || {})['en']]
end
