# coding: utf-8
class ScheduleController < LocaleBaseController
  skip_before_filter :login_required
  skip_filter :assign_locale, :only => :all

  layout_for_latest_ruby_kaigi

  def grid
    @timetable = RubyKaigi2011::Timetable.new
    @rooms = RubyKaigi2011::Room.all
    @body_id = 'schedule'
  end

  def details
    timetable = RubyKaigi2011::Timetable.new
    @event = RubyKaigi2011::Event.find(params[:id])
    room_timetable = timetable.room_timetable_contains_event(@event)
    @session_of_event = room_timetable.session_contains_event(@event)
    @room = RubyKaigi2011::Room.find(room_timetable.room_id)
  end

  def all
    @schedule = RubyKaigi2011::Timetable.new
    respond_to do |format|
      format.json { render :json => @schedule.to_hash.to_json }
    end
  end
end
