module RubyKaigi2011
  module Localizer
    def localize(locale, *attr_names)
      value = retrieve(*attr_names)

      if value.is_a?(Hash)
        value_for_locale(locale, value)
      else
        value
      end
    end

    private
    def retrieve(*path)
      first, *rest = path
      rest.inject(self.send(first)) { |current, key| current[key.to_s] }
    end

    def value_for_locale(locale, hash)
      locales_in_order(locale).inject(nil) { |value, l| value || hash[l.to_s] }
    end

    def locales_in_order(locale, default_locale = 'en')
      [locale, default_locale].uniq
    end
  end
end
