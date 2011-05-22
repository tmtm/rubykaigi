# coding: utf-8
class ScheduleController < LocaleBaseController
  skip_before_filter :login_required
  skip_filter :assign_locale, :only => :all

  layout_for_latest_ruby_kaigi

  def grid
    @timetable = RubyKaigi2011::Timetable.new
    @rooms = RubyKaigi2011::Room.all
    params[:page_name] = 'programs'
  end

  def all
    @schedule = RubyKaigi2011::Timetable.new
    respond_to do |format|
      format.json { render :json => @schedule.to_hash.to_json }
    end
  end
end
