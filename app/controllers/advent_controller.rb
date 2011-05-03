class AdventController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  # GET /advent
  def index
    require 'open-uri'

    ical = URI.parse(configatron.advent.ical_url).open(&:read)
    @advent = RiCal.parse_string(ical).first

    respond_to do |format|
      format.html { render :layout => 'simple' } # TODO: use latest_ruby_kaigi layout 
      format.json { render :json => advent_to_json }
    end
  end

  private

    def advent_to_json
      @advent.events.map {|event|
        {:summary => event.summary,
         :dtstart => event.dtstart,
         :dtend   => event.dtend,
         :location => event.location,
         :description => event.description}
      }.to_json
    end

end
