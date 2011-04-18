module HelperMethods
  def header(key, value)
    page.driver.header key, value
  end
end

RSpec.configuration.include(HelperMethods)
