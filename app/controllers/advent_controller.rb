class AdventController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  before_filter :load_events

  # GET /advent
  def index
    respond_to do |format|
      format.html
      format.json { render :json => events_to_json }
      format.ics { render :text => @advent.to_s }
    end
  end

  private
  
    def load_events
      require 'open-uri'
  
      ical = URI.parse(configatron.advent.ical_url).open(&:read)
      @advent = RiCal.parse_string(ical).first
      @events = @advent.events.map!{|e| translate_event(e) }.sort_by(&:dtstart)
    end

    def translate_event(event)
      event.summary = I18n.t! event.summary.intern, :scope => :advent rescue event.summary
      event
    end

    def events_to_json
      @events.map {|event|
        {:summary => event.summary,
         :dtstart => event.dtstart,
         :dtend   => event.dtend,
         :location => event.location,
         :description => event.description}
      }.to_json
    end

end
