module RubyKaigi2011
  module Localizer

    def localize(locale, *attr_names)
      attrs = self.send(attr_names.shift)
      value = attr_names.inject(attrs) do |context , attr_name|
        context[attr_name.to_s]
      end
      return value unless value.is_a?(Hash)

      locale_orders(locale).each do |l|
        return value[l] if value[l]
      end
    end

    private
    def default_locale
      'en'
    end

    def locale_orders(locale)
      [locale.to_s, default_locale].uniq
    end
  end
end
