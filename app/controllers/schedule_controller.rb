# coding: utf-8
class ScheduleController < LocaleBaseController
  skip_before_filter :login_required

  layout_for_latest_ruby_kaigi

  def grid
    @timetable = RubyKaigi2011::Timetable.new
    @rooms = RubyKaigi2011::Room.all
    params[:page_name] = 'programs'
  end
end
