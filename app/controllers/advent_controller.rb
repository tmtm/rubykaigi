class AdventController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  before_filter :load_events

  # GET /advent
  def index
    respond_to do |format|
      format.html
      format.json { render :json => advent_to_json }
    end
  end

  private
  
  def load_events
    require 'open-uri'

    ical = URI.parse(configatron.advent.ical_url).open(&:read)
    @advent = RiCal.parse_string(ical).first
    @events = @advent.events.sort_by(&:dtstart)
  end

    def advent_to_json
      @events.map {|event|
        {:summary => event.summary,
         :dtstart => event.dtstart,
         :dtend   => event.dtend,
         :location => event.location,
         :description => event.description}
      }.to_json
    end

end
