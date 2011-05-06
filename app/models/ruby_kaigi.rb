# -*- coding: utf-8 -*-
class RubyKaigi < ActiveRecord::Base
  class << self
    def year(year)
      RubyKaigi.find_by_year(year)
    end

    (2006..2011).to_a.each do |year|
      define_method("_#{year}") do
        RubyKaigi.year(year)
      end
    end
    alias :latest :_2011

    def latest_year
      latest.year
    end
  end
end
