# coding: utf-8
class ProgramsController < LocaleBaseController
  skip_before_filter :login_required

  layout_for_latest_ruby_kaigi

  def index
    @timetable = RubyKaigi2011::Timetable.new
    @rooms = RubyKaigi2011::Room.all
    params[:page_name] = 'programs'
  end
end
