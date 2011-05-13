# coding: utf-8
class TimetableController < LocaleBaseController
  skip_before_filter :login_required

  layout_for_latest_ruby_kaigi

  def index
    @timetable = RubyKaigi2011::Timetable.new
    @rooms = RubyKaigi2011::Room.all
    params[:page_name] = 'programs'
  end

  def show
  end

  def event
    timetable = RubyKaigi2011::Timetable.new
    @event = RubyKaigi2011::Event.find(params[:id])
    room_timetable = timetable.room_timetable_contains_event(@event)
    @session = room_timetable.session_contains_event(@event)
    @room = RubyKaigi2011::Room.find(room_timetable.room_id)
  end
end
