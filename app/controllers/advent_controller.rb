class AdventController < LocaleBaseController
  layout_for_latest_ruby_kaigi

  # GET /advent
  def index
    AdventEvent.load params[:year]
    respond_to do |format|
      format.html
      format.json { render :json => AdventEvent.to_json }
      format.ics { render :text => AdventEvent.to_ical }
    end
  end

end
