class AdventController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  # GET /advent
  def index
    require 'open-uri'

    ical = URI.parse(configatron.advent.ical_url).open(&:read)
    @advent = RiCal.parse_string(ical).first

    render :layout => 'simple' # TODO: use latest_ruby_kaigi layout
  end

end
